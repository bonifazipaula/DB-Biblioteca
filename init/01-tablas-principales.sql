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

CREATE TABLE idioma (
    id_idioma INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
);

CREATE TABLE estanteria (
    id_estanteria INT AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE editorial (
    id_editorial INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL
);

CREATE TABLE tema (
    id_tema INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(150) NOT NULL
);

CREATE TABLE palabra_clave (
    id_palabra INT AUTO_INCREMENT PRIMARY KEY,
    palabra VARCHAR(100) NOT NULL
);

CREATE TABLE lector (
    nro_lector INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cuil VARCHAR(20) NOT NULL UNIQUE,
    telefono VARCHAR(30)
);

CREATE TABLE materia (
    cod_mat VARCHAR(20) PRIMARY KEY,
    descripcion VARCHAR(150) NOT NULL
);