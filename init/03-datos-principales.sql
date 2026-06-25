USE biblioteca_db;

-- =========================
-- LIBROS (Ampliados)
-- =========================
INSERT INTO libro (id_libro, titulo) VALUES
(1, 'Introduccion a las Bases de Datos'),
(2, 'Fundamentos de Programacion en C y C++'),
(3, 'Sistemas Operativos Modernos'),
(4, 'Redes de Computadoras'),
(5, 'Ingenieria de Software Aplicada'),
(6, 'Matematica Discreta'),
(7, 'Algoritmos y Estructuras de Datos en C'),
(8, 'Arquitectura de Computadoras y Microcontroladores'),
(9, 'Inteligencia Artificial: Un Enfoque Moderno'),
(10, 'Seguridad Informatica'),
(11, 'SQL Avanzado'),
(12, 'Analisis y Diseño de Sistemas'),
(13, 'Logica Computacional'),
(14, 'Programacion Orientada a Objetos: Patrones de Diseño'),
(15, 'Administracion de Proyectos Informaticos'),
(16, 'Clean Code: Manual de Estilo Ágil'),
(17, 'Refactoring: Mejorando el Diseño del Código Existente'),
(18, 'Desarrollo de Sistemas de Visión Artificial con YOLO'),
(19, 'Edge Computing: IA en Dispositivos Embebidos (Jetson & Pi)'),
(20, 'Higiene y Seguridad en Entornos Industriales'),
(21, 'Microeconomia Básica y Teoría del Consumidor'),
(22, '1984'),
(23, 'Cien Años de Soledad'),
(24, 'El Aleph'),
(25, 'Fahrenheit 451'),
(26, 'Teoría de Señales y Sistemas Lineales'),
(27, 'Sistemas de Control Industrial (VHDL y Ladder)'),
(28, 'Bases de Datos NoSQL'),
(29, 'Machine Learning con Python y Google Colab'),
(30, 'Criptografía Aplicada');

-- =========================
-- AUTORES (Ampliados)
-- =========================
INSERT INTO autor (id_autor, nombre, apellido, nom_fantasia, biografia, f_nacimiento) VALUES
(1, 'Carlos', 'Gomez', NULL, 'Especialista en bases de datos relacionales.', '1975-04-12'),
(2, 'Maria', 'Fernandez', NULL, 'Docente e investigadora.', '1980-09-23'),
(3, 'Juan', 'Perez', 'J. P. Sistemas', 'Autor de sistemas operativos.', '1968-01-30'),
(4, 'Laura', 'Martinez', NULL, 'Investigadora en redes.', '1977-11-15'),
(5, 'Martin', 'Fowler', NULL, 'Padre de la arquitectura de software y refactoring.', '1963-12-18'),
(6, 'Robert', 'Martin', 'Uncle Bob', 'Autor de Clean Code.', '1952-12-05'),
(7, 'Diego', 'Ramirez', NULL, 'Especialista en Algoritmos en C.', '1982-12-02'),
(8, 'Yann', 'LeCun', NULL, 'Pionero en Redes Neuronales y Visión Artificial.', '1960-07-08'),
(9, 'George', 'Orwell', NULL, 'Novelista distópico.', '1903-06-25'),
(10, 'Gabriel', 'García Márquez', 'Gabo', 'Premio Nobel de Literatura.', '1927-03-06'),
(11, 'Jorge Luis', 'Borges', NULL, 'Escritor argentino.', '1899-08-24'),
(12, 'Ray', 'Bradbury', NULL, 'Escritor de ciencia ficción.', '1920-08-22'),
(13, 'Silvia', 'Lopez', NULL, 'Auditora de normas ISO y seguridad industrial.', '1978-05-14'),
(14, 'Paul', 'Krugman', NULL, 'Economista y premio Nobel.', '1953-02-28'),
(15, 'Alan', 'Oppenheim', NULL, 'Experto en procesamiento de señales.', '1937-11-11');

-- =========================
-- IDIOMAS, ESTANTERIAS, EDITORIALES
-- =========================
INSERT INTO idioma (id_idioma, descripcion) VALUES (1, 'Español'), (2, 'Ingles'), (3, 'Portugues'), (4, 'Frances');

INSERT INTO estanteria (id_estanteria) VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12);

INSERT INTO editorial (id_editorial, nombre) VALUES
(1, 'Editorial Universitaria'), (2, 'Alfaomega'), (3, 'Pearson'), (4, 'McGraw Hill'), 
(5, 'Siglo XXI'), (6, 'OReilly Media'), (7, 'Addison-Wesley'), (8, 'Sudamericana');

-- =========================
-- TEMAS y PALABRAS CLAVE (Adaptados)
-- =========================
INSERT INTO tema (id_tema, descripcion) VALUES
(1, 'Bases de datos'), (2, 'Programacion C/C++'), (3, 'Sistemas operativos'), (4, 'Redes'), 
(5, 'Arquitectura de software'), (6, 'Matematica y Logica'), (7, 'Hardware y Edge Computing'), 
(8, 'Inteligencia Artificial y Visión'), (9, 'Seguridad informatica y Criptografía'), 
(10, 'Literatura y Ficción'), (11, 'Economia y Microeconomia'), (12, 'Seguridad Industrial');

INSERT INTO palabra_clave (id_palabra, palabra) VALUES
(1, 'SQL'), (2, 'Normalizacion'), (3, 'Patrones'), (4, 'C++'), (5, 'Punteros'),
(6, 'YOLO'), (7, 'OpenCV'), (8, 'Jetson'), (9, 'IoT'), (10, 'Refactoring'),
(11, 'EPP'), (12, 'Curva Engel'), (13, 'Distopia'), (14, 'Realismo Magico'), (15, 'Senales');

-- =========================
-- LECTORES (Alumnos y Profesores)
-- =========================
INSERT INTO lector (nro_lector, nombre, apellido, cuil, telefono) VALUES
(1, 'Manuel', 'Diaz', '20-40111222-3', '2235551001'), (2, 'Lucia', 'Gomez', '27-42111333-4', '2235551002'),
(3, 'Tomas', 'Herrera', '20-39111444-5', '2235551003'), (4, 'Camila', 'Ruiz', '27-43111555-6', '2235551004'),
(5, 'Agustin', 'Molina', '20-38111666-7', '2235551005'), (6, 'Valentina', 'Castro', '27-44111777-8', '2235551006'),
(7, 'Martin', 'Suarez', '20-35111888-9', '2235551007'), (8, 'Paula', 'Benitez', '27-36111999-0', '2235551008'),
(9, 'Federico', 'Romero', '20-37111000-1', '2235551009'), (10, 'Julieta', 'Acosta', '27-38112111-2', '2235551010'),
(11, 'Ricardo', 'Alvarez', '20-29112222-3', '2235551011'), (12, 'Silvia', 'Moreno', '27-30112333-4', '2235551012'),
(13, 'Nicolas', 'Arias', '20-33112444-5', '2235551013'), (14, 'Florencia', 'Vega', '27-34112555-6', '2235551014'),
(15, 'Bruno', 'Navarro', '20-32112666-7', '2235551015'), (16, 'Melina', 'Ortega', '27-31112777-8', '2235551016'),
(17, 'Lucas', 'Paz', '20-30112888-9', '2235551017'), (18, 'Carolina', 'Rios', '27-29112999-0', '2235551018'),
(19, 'Esteban', 'Quito', '20-41222333-4', '2235551019'), (20, 'Mariana', 'Luz', '27-42333444-5', '2235551020');

-- =========================
-- MATERIAS
-- =========================
INSERT INTO materia (cod_mat, descripcion) VALUES
('BD01', 'Bases de Datos I'), ('PROG1', 'Programacion Orientada a Objetos'),
('SO01', 'Sistemas Operativos'), ('RED01', 'Redes de Computadoras'),
('IS01', 'Arquitectura y Diseño de Software'), ('MAT01', 'Matematica Discreta'),
('VC01', 'Sistemas de Visión Computacional'), ('EC01', 'Edge Computing e IoT'),
('SEG01', 'Seguridad e Higiene Industrial'), ('MIC01', 'Microeconomia'),
('SEN01', 'Teoría de Señales');