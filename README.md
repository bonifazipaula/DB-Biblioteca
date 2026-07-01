# 📚 Sistema de Gestión de Biblioteca - Trabajo Práctico

Este proyecto consiste en el desarrollo de un sistema de gestión para una biblioteca. La aplicación permite realizar préstamos, gestionar ejemplares, consultar estadísticas y administrar notificaciones automáticas para los lectores, integrando una arquitectura de base de datos robusta con un motor de MySQL.

Este trabajo fue desarrollado para la cátedra **Diseño de Base de Datos y Bases de Datos** de la Facultad de Ingeniería de la UNMdP.

## 🛠️ Tecnologías Utilizadas

* **Backend:** [Node.js](https://nodejs.org/) con [Inquirer.js](https://inquirer.js.org/) para la interfaz de línea de comandos y [mysql2](https://www.npmjs.com/package/mysql2) para la comunicación con la base de datos.
* **Base de Datos:** [MySQL 8.4](https://www.mysql.com/).
* **Infraestructura:** [Docker](https://www.docker.com/) y [Docker Compose](https://docs.docker.com/compose/) para la contenerización del motor de BD y [phpMyAdmin](https://www.phpmyadmin.net/) para la administración.

## 🚀 Funcionalidades Implementadas


1. **Gestión de Préstamos:** Consulta de préstamos vencidos a una fecha específica con datos del deudor.


2. **Estado de Ejemplares:** Visualización dinámica de la disponibilidad de ejemplares por libro, autor, tema o recomendación docente.


3. **Estadísticas Mensuales:** Comparativa interanual de préstamos por título, autor, editorial y tema.


4. **Notificaciones Automáticas:** Stored Procedure para identificar lectores que deben recibir avisos sobre nuevos libros.


5. **Integridad y Control:**
* **Triggers:** Bloqueo automático de préstamos a lectores morosos.
* **Transacciones (ACID):** Registro seguro de préstamos garantizando la integridad entre la cabecera y el detalle.



## ⚙️ Configuración y Ejecución

### Requisitos previos

* Tener instalado [Docker](https://www.docker.com/) y [Docker Compose](https://docs.docker.com/compose/).
* Tener instalado [Node.js](https://nodejs.org/).

### Instrucciones

1. **Clonar el repositorio:**
```bash
git clone https://github.com/bonifazipaula/DB-Biblioteca.git
cd DB-Biblioteca

```


2. **Levantar el entorno de Docker:**
```bash
./up.sh

```


3. **Instalar dependencias de Node.js:**
```bash
npm install

```


4. **Ejecutar la aplicación:**
```bash
node app.js

```



## 📂 Estructura de la Base de Datos (`/init`)

El sistema inicializa automáticamente la base de datos con los scripts ubicados en `/init`, siguiendo el orden de ejecución necesario para las restricciones de integridad y dependencias:

* `01-tablas-principales.sql`: Creación de tablas base.
* `02-tablas-relaciones.sql`: Definición de claves foráneas y restricciones.
* `03-datos-principales.sql` al `11-...`: Inserción de datos de prueba, vistas, procedimientos almacenados y triggers.

## 👥 Integrantes

* Cotado Lemuel Esteban
* Bonifazi Paula
* Estrada Matias Valentín
* Perez Cabrera Manuel
* Turina Jorge Agustín

