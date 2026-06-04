USE biblioteca_db;

-- =========================
-- CONSULTAS / PRUEBAS
-- =========================

-- Ver todos los libros
SELECT * FROM libro;

-- Ver todos los autores
SELECT * FROM autor;

-- Ver qué autor escribió qué libro
SELECT 
    a.id_autor,
    a.nombre,
    a.apellido,
    l.id_libro,
    l.titulo
FROM autor AS a
JOIN escrito_por AS ep
    ON a.id_autor = ep.id_autor
JOIN libro AS l
    ON ep.id_libro = l.id_libro;


-- =========================
-- CARGAR ALGUNOS DATOS NUEVOS
-- =========================

INSERT INTO libro (titulo)
VALUES
('Ficciones'),
('Cien años de soledad'),
('La invención de Morel');

INSERT INTO autor (nombre, apellido)
VALUES
('Jorge Luis', 'Borges'),
('Gabriel', 'García Márquez'),
('Adolfo', 'Bioy Casares');


-- Relacionar autores con libros
-- Ojo: esto asume que los IDs siguen el orden de inserción.
-- Si ya tenías datos previos, puede que los IDs sean otros.

INSERT INTO escrito_por (id_autor, id_libro)
VALUES
(3, 3),
(4, 4),
(5, 5);


-- =========================
-- CONSULTA FINAL PARA VER TODO
-- =========================

SELECT 
    l.id_libro,
    l.titulo,
    CONCAT(a.nombre, ' ', a.apellido) AS autor
FROM libro AS l
JOIN escrito_por AS ep
    ON l.id_libro = ep.id_libro
JOIN autor AS a
    ON ep.id_autor = a.id_autor
ORDER BY l.id_libro;