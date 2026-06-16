#!/bin/bash

echo "Cargando..."
#docker compose down -v
docker compose down
docker compose up -d

echo "¡Contenedores iniciados!"
echo "MySQL está corriendo en el puerto 3307."
echo "Podés visualizar la base de datos en phpMyAdmin ingresando a http://localhost:8081"