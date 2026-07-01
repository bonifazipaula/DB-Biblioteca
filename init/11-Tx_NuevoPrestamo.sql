USE biblioteca_db;

/*
Modela una transacción de principio a fin 
(respetando las propiedades ACID) en la creación de un nuevo préstamo.
Un préstamo no existe de forma aislada, es un registro "Cabecera" 
(tabla prestamo) que obligatoriamente necesita registros "Detalle" (tabla incluye). 
Si la base de datos se cae justo después de insertar la cabecera pero antes de insertar 
los ejemplares incluidos, el sistema quedaría en un estado inconsistente (un préstamo fantasma sin libros).
Para evitar esto, creamos este Stored Procedure que envuelve ambas inserciones. 
Además, implementamos un manejador de excepciones (DECLARE EXIT HANDLER) 
que ejecuta un ROLLBACK automático si algo falla.
*/

DELIMITER //

CREATE PROCEDURE SP_Registrar_Nuevo_Prestamo(
    IN p_nro_lector INT,
    IN p_fh_fin DATETIME,
    IN p_isbn VARCHAR(20),
    IN p_nro_ejemplar INT
)
BEGIN
    -- Declaramos una variable para capturar el ID autogenerado
    DECLARE v_id_prestamo INT;

    -- Manejador de errores: Si falla cualquier insert, se deshace todo
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
        RESIGNAL; -- Vuelve a lanzar el error para que el usuario/aplicación lo vea
    END;

    -- Iniciamos la transacción segura
    START TRANSACTION;

    -- 1. Insertamos la Cabecera (El registro del préstamo)
    INSERT INTO prestamo (fh_inicio, fh_fin, fh_devolucion, nro_lector)
    VALUES (NOW(), p_fh_fin, NULL, p_nro_lector);

    -- Capturamos el ID del préstamo que MySQL acaba de generar
    SET v_id_prestamo = LAST_INSERT_ID();

    -- 2. Insertamos el Detalle (El ejemplar físico asociado)
    INSERT INTO incluye (id_prestamo, isbn, nro_ejemplar)
    VALUES (v_id_prestamo, p_isbn, p_nro_ejemplar);

    -- 3. Actualizamos el estado del ejemplar a 'Prestado'
    UPDATE ejemplar 
    SET estado = 'Prestado' 
    WHERE isbn = p_isbn AND nro_ejemplar = p_nro_ejemplar;

    -- Si llegamos hasta acá sin errores, confirmamos todos los cambios a la vez
    COMMIT;

END //

DELIMITER ;

/*
Prueba A: Ejecución Exitosa (COMMIT)
Le vamos a prestar el ejemplar 4 del libro "Introducción a las Bases de Datos" (ISBN: 978-000-01) al Lector 15.
*/

-- 1. Verificamos el estado inicial del ejemplar (Debería decir 'Disponible')
SELECT isbn, nro_ejemplar, estado 
FROM ejemplar 
WHERE isbn = '978-000-01' AND nro_ejemplar = 4;

-- 2. Ejecutamos la transacción para registrar el préstamo
CALL SP_Registrar_Nuevo_Prestamo(15, DATE_ADD(NOW(), INTERVAL 14 DAY), '978-000-01', 4);

-- 3. Verificamos que se creó el nuevo préstamo en la cabecera y el detalle
SELECT * FROM prestamo ORDER BY id_prestamo DESC LIMIT 1;
SELECT * FROM incluye ORDER BY id_prestamo DESC LIMIT 1;

-- 4. Comprobamos que el ejemplar se actualizó automáticamente
SELECT isbn, nro_ejemplar, estado 
FROM ejemplar 
WHERE isbn = '978-000-01' AND nro_ejemplar = 4;

/*
Resultado esperado: Ver que todo se insertó correctamente y el estado del ejemplar en la última 
consulta cambia de 'Disponible' a 'Prestado'.
*/

/*
Prueba B: Falla Controlada (ROLLBACK)
Registramos un préstamo pasándole un ISBN falso ('000-ERROR-000').
Dentro del Stored Procedure, el primer paso (insertar la cabecera en prestamo) funcionará perfectamente en la memoria del servidor. 
Sin embargo, el segundo paso (insertar en incluye) falla porque la clave foránea no encontrará 
ese ISBN en la tabla de ediciones. Es aquí donde el EXIT HANDLER atrapa el error y 
ejecuta el ROLLBACK para evitar que quede un préstamo fantasma sin libros.
*/

-- 1. Vemos nota de cuál es el último id_prestamo válido en el sistema
SELECT MAX(id_prestamo) AS ultimo_id_antes_del_error FROM prestamo;

-- 2. Forzamos el error pasando un ISBN inexistente
CALL SP_Registrar_Nuevo_Prestamo(16, DATE_ADD(NOW(), INTERVAL 14 DAY), '000-ERROR-000', 1);

-- 3. Volvemos a consultar el último id_prestamo
SELECT MAX(id_prestamo) AS ultimo_id_despues_del_error FROM prestamo;

/*
Resultado esperado: Al ejecutar el CALL, el motor va a arrojar el error nativo 
de clave foránea (Error Code: 1452. Cannot add or update a child row...).
Al ejecutar la última consulta (Paso 3), se debe ver que el ID máximo 
sigue siendo exactamente el mismo que en el Paso 1. Esto demuestra que la transacción 
deshizo silenciosamente el INSERT de la cabecera que había logrado ejecutarse, manteniendo 
la base de datos limpia.
*/