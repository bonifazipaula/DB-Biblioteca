USE biblioteca_db;

DELIMITER //

CREATE PROCEDURE SP_Lectores_Notificar_Nuevo_Libro_Clasico(IN p_id_libro_nuevo INT)
BEGIN
    -- 1. Identifica al autor del libro que acaba de ingresar
    DECLARE v_id_autor INT;
    SELECT id_autor INTO v_id_autor 
    FROM escrito_por 
    WHERE id_libro = p_id_libro_nuevo 
    LIMIT 1;

    -- 2. División
    SELECT l.nro_lector, l.nombre, l.apellido, l.cuil
    FROM   lector l
    WHERE  NOT EXISTS (SELECT *
                       FROM   escrito_por ep
                       WHERE  ep.id_autor = v_id_autor AND ep.id_libro != p_id_libro_nuevo
                       AND NOT EXISTS (SELECT *
                                       FROM   prestamo pr
                                       JOIN   incluye i ON pr.id_prestamo = i.id_prestamo
                                       JOIN   edicion ed ON i.isbn = ed.isbn
                                       WHERE  ed.id_libro = ep.id_libro AND
                                              pr.nro_lector = l.nro_lector))
    -- No envia notificaciones si el autor es completamente nuevo, ya que entonces nadie leyo
    -- ninguno de sus libros.
    AND EXISTS (SELECT 1 FROM prestamo p2 WHERE p2.nro_lector = l.nro_lector);

END //

DELIMITER ;

-- Inserta el nuevo libro
INSERT INTO libro (titulo) 
VALUES ('El nuevo nuevo libro del autor 2');

-- Captura el ID del libro recién creado
SET @nuevo_libro = LAST_INSERT_ID();

-- Se asocia al autor 2
INSERT INTO escrito_por (id_autor, id_libro) 
VALUES (2, @nuevo_libro);

-- Ejecuta la notificación
CALL SP_Lectores_Notificar_Nuevo_Libro_Clasico(@nuevo_libro);