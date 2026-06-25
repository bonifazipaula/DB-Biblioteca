USE biblioteca_db;

-- =========================
-- RELACIONES DE AUTORIA
-- =========================
INSERT INTO escrito_por (id_autor, id_libro) VALUES
(1,1), (1,11), (2,2), (7,7), (3,3), (4,4), (5,5), (5,16), (5,17), -- Martin Fowler tiene 3 libros (5, 16, 17)
(6,16), (8,9), (8,18), (8,29), (13,20), (14,21), (9,22), (10,23), 
(11,24), (12,25), (15,26), (4,27), (1,28), (15,30);

-- =========================
-- IDIOMAS Y EDICIONES
-- =========================
INSERT INTO escrito_en (id_libro, id_idioma) VALUES
(1,1), (2,1), (3,1), (5,2), (16,2), (17,2), (18,2), (19,2), (20,1), (21,1), (22,1), (23,1);

INSERT INTO edicion (isbn, indice, f_publicacion, id_libro, id_estanteria, id_editorial) VALUES
('978-000-01', 'Indice BD', '2020-03-15', 1, 1, 1),
('978-000-02', 'Indice C/C++', '2019-08-10', 2, 1, 2),
('978-000-05', 'Indice Software', '2022-02-12', 5, 2, 7),
('978-000-16', 'Indice Clean Code', '2008-08-01', 16, 2, 7),
('978-000-17', 'Indice Refactoring', '1999-07-08', 17, 2, 7),
('978-000-18', 'Indice YOLO', '2023-01-10', 18, 3, 6),
('978-000-19', 'Indice Edge Jetson', '2022-05-20', 19, 3, 6),
('978-000-20', 'Indice ART', '2018-11-30', 20, 4, 1),
('978-000-21', 'Indice Curva Engel', '2015-04-12', 21, 5, 4),
('978-000-22', 'Indice 1984', '1949-06-08', 22, 6, 8),
('978-000-23', 'Indice Macondo', '1967-05-30', 23, 6, 8);

-- =========================
-- EJEMPLARES (2 copias físicas de cada libro importante)
-- =========================
INSERT INTO ejemplar (isbn, nro_ejemplar, estado) VALUES
('978-000-01', 1, 'Disponible'), ('978-000-01', 2, 'Disponible'),
('978-000-02', 1, 'Disponible'), ('978-000-02', 2, 'Disponible'),
('978-000-05', 1, 'Disponible'), ('978-000-05', 2, 'Disponible'),
('978-000-16', 1, 'Disponible'), ('978-000-16', 2, 'Disponible'),
('978-000-17', 1, 'Disponible'), ('978-000-17', 2, 'Disponible'),
('978-000-18', 1, 'Disponible'), ('978-000-18', 2, 'Disponible'),
('978-000-19', 1, 'Disponible'), ('978-000-19', 2, 'Disponible'),
('978-000-20', 1, 'Disponible'), ('978-000-20', 2, 'Disponible'),
('978-000-21', 1, 'Disponible'), ('978-000-22', 1, 'Disponible'),
('978-000-23', 1, 'Disponible'), ('978-000-23', 2, 'Dañado');

-- =========================
-- TEMAS Y PALABRAS CLAVE ASOCIADAS
-- =========================
INSERT INTO trata (id_tema, isbn) VALUES
(1, '978-000-01'), (2, '978-000-02'), (5, '978-000-05'), (5, '978-000-16'),
(5, '978-000-17'), (8, '978-000-18'), (7, '978-000-19'), (12, '978-000-20'),
(11, '978-000-21'), (10, '978-000-22'), (10, '978-000-23');

INSERT INTO se_identifica_con (id_palabra, isbn) VALUES
(1, '978-000-01'), (4, '978-000-02'), (10, '978-000-17'), (6, '978-000-18'),
(8, '978-000-19'), (11, '978-000-20'), (12, '978-000-21'), (13, '978-000-22');

-- =========================
-- ROLES ACADEMICOS
-- =========================
INSERT INTO alumno (nro_lector, lu) VALUES
(1, 'LU-1001'), (2, 'LU-1002'), (3, 'LU-1003'), (4, 'LU-1004'), (5, 'LU-1005'),
(6, 'LU-1006'), (7, 'LU-1007'), (8, 'LU-1008'), (9, 'LU-1009'), (10, 'LU-1010'),
(19, 'LU-1019'), (20, 'LU-1020');

INSERT INTO profesor (nro_lector) VALUES (11), (12), (13), (14), (15), (16), (17), (18);

INSERT INTO dicta (nro_lector, cod_mat) VALUES
(11, 'BD01'), (12, 'PROG1'), (13, 'VC01'), (13, 'EC01'), (14, 'SEG01'), (15, 'MIC01');

-- =========================
-- HISTORIAL DE PRÉSTAMOS (Años diversos y Division Relacional)
-- =========================
-- ATENCIÓN: Las fechas se distribuyen para alimentar las métricas interanuales (LAG)

INSERT INTO prestamo (id_prestamo, fh_inicio, fh_fin, fh_devolucion, nro_lector) VALUES
-- Préstamos históricos del Año 2024
(1, '2024-05-10 10:00:00', '2024-05-24 10:00:00', '2024-05-20 10:00:00', 2),
(2, '2024-06-15 11:00:00', '2024-06-29 11:00:00', '2024-06-28 11:00:00', 3),

-- Préstamos históricos del Año 2025 (Mismos meses para contrastar con 2026)
(3, '2025-05-05 09:00:00', '2025-05-19 09:00:00', '2025-05-18 09:00:00', 4),
(4, '2025-05-20 14:00:00', '2025-06-03 14:00:00', '2025-06-01 14:00:00', 5),
(5, '2025-06-10 16:00:00', '2025-06-24 16:00:00', '2025-06-25 16:00:00', 6),

-- Préstamos recientes del Año 2026
(6, '2026-05-02 10:00:00', '2026-05-16 10:00:00', '2026-05-15 10:00:00', 7),
(7, '2026-05-18 11:30:00', '2026-06-01 11:30:00', NULL, 8), -- VENCIDO A LA FECHA DE HOY
(8, '2026-06-05 09:15:00', '2026-06-19 09:15:00', NULL, 9), -- ACTIVO
(9, '2026-06-10 15:45:00', '2026-06-24 15:45:00', NULL, 10), -- ACTIVO

-- =========================================================================
-- EL CASO "DIVISIÓN RELACIONAL" (Lector 1 lee todo de Martin Fowler)
-- Martin Fowler (Autor 5) tiene 3 libros en BD: 5, 16 y 17.
-- =========================================================================
(10, '2025-03-01 10:00:00', '2025-03-15 10:00:00', '2025-03-10 10:00:00', 1),
(11, '2025-08-01 10:00:00', '2025-08-15 10:00:00', '2025-08-12 10:00:00', 1),
(12, '2026-02-01 10:00:00', '2026-02-15 10:00:00', '2026-02-14 10:00:00', 1),

-- Profesores llevando material técnico en 2026
(13, '2026-05-12 10:00:00', '2026-05-26 10:00:00', '2026-05-25 10:00:00', 13),
(14, '2026-06-01 10:00:00', '2026-06-15 10:00:00', '2026-06-14 10:00:00', 14);

-- =========================
-- INCLUYE (Asignación de ejemplares a los préstamos)
-- =========================
INSERT INTO incluye (id_prestamo, isbn, nro_ejemplar) VALUES
(1, '978-000-18', 1), -- Visión YOLO en 2024
(2, '978-000-22', 1), -- Literatura en 2024
(3, '978-000-18', 2), -- Visión YOLO en May 2025 (Pico de demanda interanual)
(4, '978-000-19', 1), -- Edge Computing May 2025
(5, '978-000-21', 1), -- Microeconomia Jun 2025
(6, '978-000-18', 1), -- Visión YOLO May 2026 (Para comparar con prestamo 3)
(7, '978-000-20', 1), -- Seguridad Industrial (VENCIDO)
(8, '978-000-02', 1), -- Programación C/C++ (ACTIVO)
(9, '978-000-23', 1), -- García Márquez (ACTIVO)

-- Los 3 libros de Martin Fowler leídos por el Lector 1
(10, '978-000-05', 1), -- Ingeniería de Software
(11, '978-000-16', 1), -- Clean Code
(12, '978-000-17', 1), -- Refactoring

-- Material técnico
(13, '978-000-19', 2), -- Edge Computing por el Prof. 13
(14, '978-000-20', 2); -- Higiene y Seguridad por la Prof. 14