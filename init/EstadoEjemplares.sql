-- Estado Ejemplares --

CREATE OR REPLACE VIEW vw_estado_ejemplares AS
SELECT 
    lib.id_libro,
    lib.titulo,
    e.isbn,
    e.nro_ejemplar,
    p.fh_inicio,
    p.fh_fin AS fecha_devolucion_esperada,
    CASE
        WHEN p.id_prestamo IS NULL THEN 'Disponible en Estanteria'
        WHEN p.fh_devolucion IS NULL AND p.fh_fin >= NOW() THEN 'Prestado - En término'
        WHEN p.fh_devolucion IS NULL AND p.fh_fin < NOW() THEN 'Prestado - Vencido'
    END AS estado_disponibilidad_real
FROM ejemplar e
JOIN edicion ed ON e.isbn = ed.isbn
JOIN libro lib ON ed.id_libro = lib.id_libro
LEFT JOIN incluye i ON e.isbn = i.isbn AND e.nro_ejemplar = i.nro_ejemplar
LEFT JOIN prestamo p ON i.id_prestamo = p.id_prestamo AND p.fh_devolucion IS NULL;

-- consulta por id_libro: indicar
SELECT * FROM vw_estado_ejemplares WHERE id_libro = 22;
/*
Filtra la vista para devolver el estado actual de todos los ejemplares que pertenecen a 
un único libro físico (en este caso, el que posee el identificador A INDICAR).
Cómo funciona: Examina la totalidad del inventario de la biblioteca y aísla los 
ejemplares (ejemplar 1, ejemplar 2, etc.) asociados al título correspondiente, permitiendo 
ver de manera centralizada cuáles están en sala y cuáles bajo préstamo activo.
*/

-- consulta por id_autor: indicar
SELECT v.* FROM vw_estado_ejemplares v
JOIN escrito_por ep ON v.id_libro = ep.id_libro
WHERE ep.id_autor = 2;
/*
Obtiene la situación de disponibilidad de todos los 
ejemplares correspondientes a cualquier libro escrito 
por un autor determinado (autor con identificador A INDICAR).
Dado que la vista no posee los datos directos del autor, se realiza 
una junta (JOIN) con la tabla de relación escrito_por. El motor busca todos los libros 
vinculados a dicho autor y luego expone el estado de cada uno de sus ejemplares.
*/


-- consulta por id_tema: indicar
SELECT v.* FROM vw_estado_ejemplares v
JOIN trata t ON v.isbn = t.isbn
WHERE t.id_tema = 4;
/*
Muestra el estado en tiempo real de los ejemplares de libros catalogados bajo un 
área temática específica (tema con identificador A INDICAR).
Conecta la información de la vista con la tabla asociativa trata
utilizando la clave del isbn. Al aplicar el filtro sobre el identificador del tema, se puede 
conocer la disponibilidad en estantería de toda la bibliografía de esa categoría.
*/

-- consulta por el profesor que lo recomienda (nro_lector): indicar
SELECT v.* FROM vw_estado_ejemplares v
JOIN recomienda r ON v.id_libro = r.id_libro
WHERE r.nro_lector = 12;
/*
Devuelve el listado y estado de los ejemplares de aquellos libros que han sido recomendados formalmente 
por un profesor (identificado en el sistema con el nro_lector A INDICAR).
Realiza un cruce de datos con la 
tabla recomienda mediante el atributo id_libro. De esta forma, el sistema 
discrimina los títulos sugeridos por ese docente para las materias y permite 
verificar de inmediato si los alumnos disponen de copias libres para retirar.
*/
