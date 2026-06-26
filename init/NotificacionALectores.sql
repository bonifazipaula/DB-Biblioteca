/*
CREATE PROCEDURE SP_Lectores_Notificar_Nuevo_Libro(IN p_id_libro_nuevo INT)
BEGIN
    SELECT DISTINCT l.nro_lector, l.nombre, l.apellido, l.cuil
    FROM lector l
    JOIN prestamo p ON l.nro_lector = p.nro_lector
    JOIN incluye i ON p.id_prestamo = i.id_prestamo
    JOIN edicion ed ON i.isbn = ed.isbn
    JOIN escrito_por ep ON ed.id_libro = ep.id_libro
    WHERE ep.id_autor IN (
        SELECT id_autor FROM escrito_por WHERE id_libro = p_id_libro_nuevo
    )
    AND ed.id_libro != p_id_libro_nuevo
    GROUP BY l.nro_lector, ep.id_autor
    HAVING COUNT(DISTINCT ed.id_libro) = (
        SELECT COUNT(DISTINCT id_libro) 
        FROM escrito_por 
        WHERE id_autor = ep.id_autor AND id_libro != p_id_libro_nuevo
    );
END
*/

DELIMITER //

CREATE PROCEDURE SP_Lectores_Notificar_Nuevo_Libro_Clasico(IN p_id_libro_nuevo INT)
BEGIN
    -- 1. Identificamos al autor del libro que acaba de ingresar
    DECLARE v_id_autor INT;
    SELECT id_autor INTO v_id_autor 
    FROM escrito_por 
    WHERE id_libro = p_id_libro_nuevo 
    LIMIT 1;

    -- 2. La consulta de División Relacional (formato diapositiva)
    SELECT L.nro_lector, L.nombre, L.apellido, L.cuil
    FROM   LECTOR L
    WHERE  NOT EXISTS (SELECT *
                       FROM   ESCRITO_POR EP
                       WHERE  EP.id_autor = v_id_autor AND EP.id_libro != p_id_libro_nuevo
                       AND NOT EXISTS (SELECT *
                                       FROM   PRESTAMO PR
                                       JOIN   INCLUYE I ON PR.id_prestamo = I.id_prestamo
                                       JOIN   EDICION ED ON I.isbn = ED.isbn
                                       WHERE  ED.id_libro = EP.id_libro AND
                                              PR.nro_lector = L.nro_lector))
    -- (Opcional pero recomendado) Evita enviar correos si el autor es totalmente nuevo 
    -- y no tenía libros previos, descartando a lectores que no tienen préstamos.
    AND EXISTS (SELECT 1 FROM PRESTAMO P2 WHERE P2.nro_lector = L.nro_lector);

END //

DELIMITER ;


INSERT INTO libro (titulo) 
VALUES ('');
-- ir poniendo nuevos titulos --

SET @nuevo_libro = LAST_INSERT_ID();

INSERT INTO escrito_por (id_autor, id_libro) 
VALUES (1, @nuevo_libro);
-- Cambiar id_autor

CALL SP_Lectores_Notificar_Nuevo_Libro(@nuevo_libro);