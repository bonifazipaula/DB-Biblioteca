-- Préstamos Vencidos a una Fecha Dada --

DELIMITER //

CREATE PROCEDURE ObtenerPrestamosVencidos(IN p_fecha_evaluacion DATETIME)
BEGIN
    SELECT 
        l.nro_lector,
        l.nombre,
        l.apellido,
        l.cuil,
        l.telefono,
        lib.titulo,
        e.isbn,
        i.nro_ejemplar,
        p.fh_fin AS fecha_vencimiento,
        DATEDIFF(p_fecha_evaluacion, p.fh_fin) AS dias_atraso
    FROM prestamo p
    JOIN lector l ON p.nro_lector = l.nro_lector
    JOIN incluye i ON p.id_prestamo = i.id_prestamo
    JOIN ejemplar e ON i.isbn = e.isbn AND i.nro_ejemplar = e.nro_ejemplar
    JOIN edicion ed ON e.isbn = ed.isbn
    JOIN libro lib ON ed.id_libro = lib.id_libro
    WHERE p.fh_fin < p_fecha_evaluacion
      AND (p.fh_devolucion IS NULL OR p.fh_devolucion > p_fecha_evaluacion);
END //

DELIMITER ;
-- PRUEBA --

CALL ObtenerPrestamosVencidos('2026-06-26 00:00:00');