USE biblioteca_db;

INSERT INTO libro (titulo)
VALUES
('El Aleph'),
('Rayuela');

INSERT INTO autor (nombre, apellido)
VALUES
('Jorge Luis', 'Borges'),
('Julio', 'Cortázar');

INSERT INTO escrito_por (id_autor, id_libro)
VALUES
(1, 1),
(2, 2);