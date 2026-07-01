/*
Trigger para Bloquear Préstamos a Lectores Morosos
Aborta la creación de un nuevo préstamo si el lector tiene libros con prestamos vencidos. 
Cancela la operación es lanzando una excepción controlada mediante el comando SIGNAL SQLSTATE.
*/

DELIMITER //

CREATE TRIGGER trg_verificar_morosidad_antes_prestamo
BEFORE INSERT ON prestamo
FOR EACH ROW
BEGIN
    DECLARE v_vencidos INT DEFAULT 0;

    -- Cuenta si el lector tiene algún préstamo donde la fecha de fin ya pasó 
    -- y el libro aún no fue devuelto
    SELECT COUNT(*) INTO v_vencidos
    FROM prestamo
    WHERE nro_lector = NEW.nro_lector
      AND fh_fin < NOW()
      AND fh_devolucion IS NULL;

    -- Si el conteo es mayor a 0, aborta el INSERT
    IF v_vencidos > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Operación denegada: El lector posee préstamos vencidos sin devolver.';
    END IF;
END //

DELIMITER ;

/*
Intenta hacer un INSERT INTO prestamo asignándole un préstamo nuevo al 
lector 20 (que en los datos de prueba tiene el préstamo 41 vencido). 
La base de datos rechaza la consulta y muestra el mensaje de texto que definimos.
*/

INSERT INTO prestamo (fh_inicio, fh_fin, fh_devolucion, nro_lector) 
VALUES (NOW(), DATE_ADD(NOW(), INTERVAL 14 DAY), NULL, 20);