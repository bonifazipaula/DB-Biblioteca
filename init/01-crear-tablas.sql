USE biblioteca_db;

CREATE TABLE libro (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL
);

CREATE TABLE autor (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nom_fantasia VARCHAR(150),
    biografia TEXT,
    f_nacimiento DATE
);

CREATE TABLE escrito_por (
    id_autor INT NOT NULL,
    id_libro INT NOT NULL,

    PRIMARY KEY (id_autor, id_libro),

    FOREIGN KEY (id_autor) REFERENCES autor(id_autor),
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro)
);

CREATE TABLE idioma (
    id_idioma INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE escrito_en (
    id_libro INT NOT NULL,
    id_idioma INT NOT NULL,

    PRIMARY KEY (id_libro, id_idioma),

    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (id_idioma) REFERENCES idioma(id_idioma)
);

CREATE TABLE estanteria (
    id_estanteria INT AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE editorial (
    id_editorial INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL
);

CREATE TABLE edicion (
    isbn VARCHAR(20) PRIMARY KEY,
    indice TEXT,
    f_publicacion DATE,
    id_libro INT NOT NULL,
    id_estanteria INT NOT NULL,
    id_editorial INT NOT NULL,

    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (id_estanteria) REFERENCES estanteria(id_estanteria),
    FOREIGN KEY (id_editorial) REFERENCES editorial(id_editorial)
);

CREATE TABLE ejemplar (
    isbn VARCHAR(20) NOT NULL,
    nro_ejemplar INT NOT NULL,
    estado VARCHAR(50) NOT NULL,

    PRIMARY KEY (isbn, nro_ejemplar),

    FOREIGN KEY (isbn) REFERENCES edicion(isbn)
);

CREATE TABLE tema (
    id_tema INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(150) NOT NULL
);

CREATE TABLE trata (
    id_tema INT NOT NULL,
    isbn VARCHAR(20) NOT NULL,

    PRIMARY KEY (id_tema, isbn),

    FOREIGN KEY (id_tema) REFERENCES tema(id_tema),
    FOREIGN KEY (isbn) REFERENCES edicion(isbn)
);

CREATE TABLE palabra_clave (
    id_palabra INT AUTO_INCREMENT PRIMARY KEY,
    palabra VARCHAR(100) NOT NULL
);

CREATE TABLE se_identifica_con (
    id_palabra INT NOT NULL,
    isbn VARCHAR(20) NOT NULL,

    PRIMARY KEY (id_palabra, isbn),

    FOREIGN KEY (id_palabra) REFERENCES palabra_clave(id_palabra),
    FOREIGN KEY (isbn) REFERENCES edicion(isbn)
);

CREATE TABLE lector (
    nro_lector INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cuil VARCHAR(20) NOT NULL UNIQUE,
    telefono VARCHAR(30)
);

CREATE TABLE alumno (
    nro_lector INT NOT NULL,
    lu VARCHAR(30) NOT NULL UNIQUE,

    PRIMARY KEY (nro_lector),

    FOREIGN KEY (nro_lector) REFERENCES lector(nro_lector)
);

CREATE TABLE egresado (
    nro_lector INT NOT NULL,
    f_egreso DATE NOT NULL,

    PRIMARY KEY (nro_lector),

    FOREIGN KEY (nro_lector) REFERENCES lector(nro_lector),

    CHECK (f_egreso <= CURRENT_DATE)
);

CREATE TABLE profesor (
    nro_lector INT NOT NULL,

    PRIMARY KEY (nro_lector),

    FOREIGN KEY (nro_lector) REFERENCES lector(nro_lector)
);

CREATE TABLE materia (
    cod_mat VARCHAR(20) PRIMARY KEY,
    descripcion VARCHAR(150) NOT NULL
);

CREATE TABLE dicta (
    nro_lector INT NOT NULL,
    cod_mat VARCHAR(20) NOT NULL,

    PRIMARY KEY (nro_lector, cod_mat),

    FOREIGN KEY (nro_lector) REFERENCES profesor(nro_lector),
    FOREIGN KEY (cod_mat) REFERENCES materia(cod_mat)
);

CREATE TABLE biblio_oblig (
    id_libro INT NOT NULL,
    cod_mat VARCHAR(20) NOT NULL,

    PRIMARY KEY (id_libro, cod_mat),

    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (cod_mat) REFERENCES materia(cod_mat)
);

CREATE TABLE biblio_opt (
    id_libro INT NOT NULL,
    cod_mat VARCHAR(20) NOT NULL,

    PRIMARY KEY (id_libro, cod_mat),

    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (cod_mat) REFERENCES materia(cod_mat)
);

CREATE TABLE recomienda (
    id_libro INT NOT NULL,
    nro_lector INT NOT NULL,
    cod_mat VARCHAR(20) NOT NULL,

    PRIMARY KEY (id_libro, nro_lector, cod_mat),

    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (nro_lector, cod_mat) REFERENCES dicta(nro_lector, cod_mat)
);

CREATE TABLE prestamo (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    fh_inicio DATETIME NOT NULL,
    fh_fin DATETIME NOT NULL,
    nro_lector INT NOT NULL,

    FOREIGN KEY (nro_lector) REFERENCES lector(nro_lector),

    CHECK (fh_inicio < fh_fin)
);

CREATE TABLE incluye (
    id_prestamo INT NOT NULL,
    isbn VARCHAR(20) NOT NULL,
    nro_ejemplar INT NOT NULL,

    PRIMARY KEY (id_prestamo, isbn, nro_ejemplar),

    FOREIGN KEY (id_prestamo) REFERENCES prestamo(id_prestamo),
    FOREIGN KEY (isbn, nro_ejemplar) REFERENCES ejemplar(isbn, nro_ejemplar)
);
