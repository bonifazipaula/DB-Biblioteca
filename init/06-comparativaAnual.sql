USE biblioteca_db;

-- Estadísticas Comparativas Interanuales --

CREATE VIEW vw_estadisticas_prestamos_titulo AS
WITH prestamos_mensuales AS (
    SELECT 
        YEAR(p.fh_inicio) AS anio,
        MONTH(p.fh_inicio) AS mes,
        lib.titulo,
        COUNT(i.id_prestamo) AS cantidad_mensual
    FROM prestamo p
    JOIN incluye i ON p.id_prestamo = i.id_prestamo
    JOIN edicion ed ON i.isbn = ed.isbn
    JOIN libro lib ON ed.id_libro = lib.id_libro
    GROUP BY YEAR(p.fh_inicio), MONTH(p.fh_inicio), lib.titulo
)
SELECT 
    anio,
    mes,
    titulo,
    cantidad_mensual,
    LAG(cantidad_mensual) OVER (PARTITION BY titulo, mes ORDER BY anio) AS cantidad_mismo_mes_anio_anterior,
    cantidad_mensual - IFNULL(LAG(cantidad_mensual) OVER (PARTITION BY titulo, mes ORDER BY anio), 0) AS diferencia_interanual
FROM prestamos_mensuales;


CREATE OR REPLACE VIEW vw_estadisticas_prestamos_autor AS
WITH prestamos_mensuales AS (
    SELECT 
        YEAR(p.fh_inicio) AS anio,
        MONTH(p.fh_inicio) AS mes,
        a.id_autor,
        CONCAT(a.nombre, ' ', a.apellido) AS autor,
        COUNT(i.id_prestamo) AS cantidad_mensual
    FROM prestamo p
    JOIN incluye i ON p.id_prestamo = i.id_prestamo
    JOIN edicion ed ON i.isbn = ed.isbn
    JOIN escrito_por ep ON ed.id_libro = ep.id_libro
    JOIN autor a ON ep.id_autor = a.id_autor
    GROUP BY YEAR(p.fh_inicio), MONTH(p.fh_inicio), a.id_autor, a.nombre, a.apellido
)
SELECT 
    anio,
    mes,
    autor,
    cantidad_mensual,
    LAG(cantidad_mensual) OVER (PARTITION BY id_autor, mes ORDER BY anio) AS cantidad_mismo_mes_anio_anterior,
    cantidad_mensual - IFNULL(LAG(cantidad_mensual) OVER (PARTITION BY id_autor, mes ORDER BY anio), 0) AS diferencia_interanual
FROM prestamos_mensuales;

CREATE OR REPLACE VIEW vw_estadisticas_prestamos_tema AS
WITH prestamos_mensuales AS (
    SELECT 
        YEAR(p.fh_inicio) AS anio,
        MONTH(p.fh_inicio) AS mes,
        t.id_tema,
        t.descripcion AS tema,
        COUNT(i.id_prestamo) AS cantidad_mensual
    FROM prestamo p
    JOIN incluye i ON p.id_prestamo = i.id_prestamo
    JOIN trata tr ON i.isbn = tr.isbn
    JOIN tema t ON tr.id_tema = t.id_tema
    GROUP BY YEAR(p.fh_inicio), MONTH(p.fh_inicio), t.id_tema, t.descripcion
)
SELECT 
    anio,
    mes,
    tema,
    cantidad_mensual,
    LAG(cantidad_mensual) OVER (PARTITION BY id_tema, mes ORDER BY anio) AS cantidad_mismo_mes_anio_anterior,
    cantidad_mensual - IFNULL(LAG(cantidad_mensual) OVER (PARTITION BY id_tema, mes ORDER BY anio), 0) AS diferencia_interanual
FROM prestamos_mensuales;

CREATE OR REPLACE VIEW vw_estadisticas_prestamos_editorial AS
WITH prestamos_mensuales AS (
    SELECT 
        YEAR(p.fh_inicio) AS anio,
        MONTH(p.fh_inicio) AS mes,
        e.id_editorial,
        e.nombre AS editorial,
        COUNT(i.id_prestamo) AS cantidad_mensual
    FROM prestamo p
    JOIN incluye i ON p.id_prestamo = i.id_prestamo
    JOIN edicion ed ON i.isbn = ed.isbn
    JOIN editorial e ON ed.id_editorial = e.id_editorial
    GROUP BY YEAR(p.fh_inicio), MONTH(p.fh_inicio), e.id_editorial, e.nombre
)
SELECT 
    anio,
    mes,
    editorial,
    cantidad_mensual,
    LAG(cantidad_mensual) OVER (PARTITION BY id_editorial, mes ORDER BY anio) AS cantidad_mismo_mes_anio_anterior,
    cantidad_mensual - IFNULL(LAG(cantidad_mensual) OVER (PARTITION BY id_editorial, mes ORDER BY anio), 0) AS diferencia_interanual
FROM prestamos_mensuales;

-- pruebas --

-- 1. Consulta por titulo: indicar año y mes
SELECT * FROM vw_estadisticas_prestamos_titulo 
WHERE anio = 2026 AND mes = 6
ORDER BY cantidad_mensual DESC;
-- VER --

-- 2. Consulta por autores: indicar año y mes
SELECT * FROM vw_estadisticas_prestamos_autor 
WHERE anio = 2025 AND mes = 5
ORDER BY cantidad_mensual DESC;

-- 3. Consulta por temas: indicar año y mes
SELECT * FROM vw_estadisticas_prestamos_tema 
WHERE anio = 2026 AND mes = 6
ORDER BY diferencia_interanual DESC;

-- 4. Consulta por editoriales: indicar año y mes
SELECT * FROM vw_estadisticas_prestamos_editorial 
WHERE anio = 2026 AND mes = 5;
