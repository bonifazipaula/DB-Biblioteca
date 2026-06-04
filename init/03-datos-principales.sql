USE biblioteca_db;

-- =========================
-- LIBROS
-- =========================

INSERT INTO libro (id_libro, titulo) VALUES
(1, 'Introduccion a las Bases de Datos'),
(2, 'Fundamentos de Programacion'),
(3, 'Sistemas Operativos Modernos'),
(4, 'Redes de Computadoras'),
(5, 'Ingenieria de Software'),
(6, 'Matematica Discreta'),
(7, 'Algoritmos y Estructuras de Datos'),
(8, 'Arquitectura de Computadoras'),
(9, 'Inteligencia Artificial'),
(10, 'Seguridad Informatica'),
(11, 'SQL Avanzado'),
(12, 'Analisis y Diseno de Sistemas'),
(13, 'Logica Computacional'),
(14, 'Programacion Orientada a Objetos'),
(15, 'Administracion de Proyectos Informaticos');

-- =========================
-- AUTORES
-- =========================

INSERT INTO autor (id_autor, nombre, apellido, nom_fantasia, biografia, f_nacimiento) VALUES
(1, 'Carlos', 'Gomez', NULL, 'Especialista en bases de datos relacionales y SQL.', '1975-04-12'),
(2, 'Maria', 'Fernandez', NULL, 'Docente universitaria e investigadora en informatica.', '1980-09-23'),
(3, 'Juan', 'Perez', 'J. P. Sistemas', 'Autor de libros sobre sistemas operativos y arquitectura.', '1968-01-30'),
(4, 'Laura', 'Martinez', NULL, 'Investigadora en redes y comunicaciones.', '1977-11-15'),
(5, 'Roberto', 'Sanchez', NULL, 'Consultor en ingenieria de software.', '1972-06-08'),
(6, 'Ana', 'Lopez', NULL, 'Especialista en matematica aplicada a computacion.', '1985-03-19'),
(7, 'Diego', 'Ramirez', NULL, 'Programador y docente de algoritmos.', '1982-12-02'),
(8, 'Sofia', 'Torres', NULL, 'Investigadora en inteligencia artificial.', '1990-07-27'),
(9, 'Esteban', 'Molina', NULL, 'Especialista en seguridad informatica.', '1979-02-11'),
(10, 'Paula', 'Castro', NULL, 'Analista de sistemas y docente universitaria.', '1988-10-05');

-- =========================
-- IDIOMAS
-- =========================

INSERT INTO idioma (id_idioma, descripcion) VALUES
(1, 'Español'),
(2, 'Ingles'),
(3, 'Portugues'),
(4, 'Frances'),
(5, 'Aleman');

-- =========================
-- ESTANTERIAS
-- =========================

INSERT INTO estanteria (id_estanteria) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8);

-- =========================
-- EDITORIALES
-- =========================

INSERT INTO editorial (id_editorial, nombre) VALUES
(1, 'Editorial Universitaria'),
(2, 'Alfaomega'),
(3, 'Pearson'),
(4, 'McGraw Hill'),
(5, 'Siglo XXI'),
(6, 'Tecnicas Aplicadas'),
(7, 'Computacion Moderna'),
(8, 'Ediciones Academicas');

-- =========================
-- TEMAS
-- =========================

INSERT INTO tema (id_tema, descripcion) VALUES
(1, 'Bases de datos'),
(2, 'Programacion'),
(3, 'Sistemas operativos'),
(4, 'Redes'),
(5, 'Ingenieria de software'),
(6, 'Matematica'),
(7, 'Algoritmos'),
(8, 'Arquitectura de computadoras'),
(9, 'Inteligencia artificial'),
(10, 'Seguridad informatica'),
(11, 'SQL'),
(12, 'Analisis de sistemas'),
(13, 'Logica'),
(14, 'Gestion de proyectos');

-- =========================
-- PALABRAS CLAVE
-- =========================

INSERT INTO palabra_clave (id_palabra, palabra) VALUES
(1, 'SQL'),
(2, 'Normalizacion'),
(3, 'Modelo relacional'),
(4, 'Programacion'),
(5, 'Variables'),
(6, 'Memoria'),
(7, 'Procesos'),
(8, 'TCP/IP'),
(9, 'Redes'),
(10, 'Requerimientos'),
(11, 'Testing'),
(12, 'Grafos'),
(13, 'Conjuntos'),
(14, 'Algoritmos'),
(15, 'Complejidad'),
(16, 'CPU'),
(17, 'Machine Learning'),
(18, 'Redes neuronales'),
(19, 'Criptografia'),
(20, 'Ciberseguridad'),
(21, 'Triggers'),
(22, 'Indices'),
(23, 'Vistas'),
(24, 'Objetos'),
(25, 'UML'),
(26, 'Proyecto');

-- =========================
-- LECTORES
-- =========================

INSERT INTO lector (nro_lector, nombre, apellido, cuil, telefono) VALUES
(1, 'Manuel', 'Diaz', '20-40111222-3', '2235551001'),
(2, 'Lucia', 'Gomez', '27-42111333-4', '2235551002'),
(3, 'Tomas', 'Herrera', '20-39111444-5', '2235551003'),
(4, 'Camila', 'Ruiz', '27-43111555-6', '2235551004'),
(5, 'Agustin', 'Molina', '20-38111666-7', '2235551005'),
(6, 'Valentina', 'Castro', '27-44111777-8', '2235551006'),
(7, 'Martin', 'Suarez', '20-35111888-9', '2235551007'),
(8, 'Paula', 'Benitez', '27-36111999-0', '2235551008'),
(9, 'Federico', 'Romero', '20-37111000-1', '2235551009'),
(10, 'Julieta', 'Acosta', '27-38112111-2', '2235551010'),
(11, 'Ricardo', 'Alvarez', '20-29112222-3', '2235551011'),
(12, 'Silvia', 'Moreno', '27-30112333-4', '2235551012'),
(13, 'Nicolas', 'Arias', '20-33112444-5', '2235551013'),
(14, 'Florencia', 'Vega', '27-34112555-6', '2235551014'),
(15, 'Bruno', 'Navarro', '20-32112666-7', '2235551015'),
(16, 'Melina', 'Ortega', '27-31112777-8', '2235551016'),
(17, 'Lucas', 'Paz', '20-30112888-9', '2235551017'),
(18, 'Carolina', 'Rios', '27-29112999-0', '2235551018');

-- =========================
-- MATERIAS
-- =========================

INSERT INTO materia (cod_mat, descripcion) VALUES
('BD01', 'Bases de Datos I'),
('BD02', 'Bases de Datos II'),
('PROG1', 'Programacion I'),
('PROG2', 'Programacion II'),
('SO01', 'Sistemas Operativos'),
('RED01', 'Redes de Computadoras'),
('IS01', 'Ingenieria de Software'),
('MAT01', 'Matematica Discreta'),
('ALG01', 'Algoritmos y Estructuras de Datos'),
('IA01', 'Inteligencia Artificial'),
('SEG01', 'Seguridad Informatica'),
('ARQ01', 'Arquitectura de Computadoras'),
('ADS01', 'Analisis y Diseno de Sistemas'),
('LOG01', 'Logica Computacional'),
('GP01', 'Gestion de Proyectos');