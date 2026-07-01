import inquirer from 'inquirer';
import mysql from 'mysql2/promise';

const dbConfig = {
    host: '127.0.0.1', 
    port: 3307,        
    user: 'root',
    password: 'root123',      
    database: 'biblioteca_db'  
};

async function mainMenu(connection) {
    let salir = false;

    while (!salir) {
        console.log('\n=================================================');
        const { opcion } = await inquirer.prompt([
            {
                type: 'select', 
                name: 'opcion',
                message: 'Sistema de Gestión de Biblioteca - ¿Qué deseas hacer?',
                choices: [
                    { name: '1. Ver estado de ejemplares de un libro (VISTA)', value: 'estado_ejemplares' },
                    { name: '2. Ver préstamos vencidos a una fecha (STORED PROCEDURE)', value: 'vencidos' },
                    { name: '3. Registrar nuevo préstamo (TRANSACCIÓN Y TRIGGER)', value: 'nuevo_prestamo' },
                    { name: '4. Ver todas las tablas (Prueba)', value: 'consultas' },
                    { name: '5. Salir', value: 'salir' }
                ]
            }
        ]);

        switch (opcion) {
            case 'estado_ejemplares':
                const { idLibro } = await inquirer.prompt([
                    { type: 'input', name: 'idLibro', message: 'Ingresá el ID del libro (ej: 1):' }
                ]);
                try {
                    // Llamamos a la VISTA usando SELECT y filtramos por el parámetro ingresado
                    const [rows] = await connection.execute('SELECT * FROM vw_estado_ejemplares WHERE id_libro = ?', [idLibro]);
                    console.table(rows);
                } catch (error) {
                    console.error('❌ Error al consultar la vista:', error.message);
                }
                break;

            case 'vencidos':
                const { fecha } = await inquirer.prompt([
                    { type: 'input', name: 'fecha', message: 'Ingresá la fecha a evaluar (YYYY-MM-DD):' }
                ]);
                try {
                    // Llamamos al STORED PROCEDURE con CALL
                    const [rows] = await connection.execute('CALL ObtenerPrestamosVencidos(?)', [`${fecha} 00:00:00`]);
                    // Los SP devuelven arreglos dobles en MySQL2, por eso imprimimos rows[0]
                    console.table(rows[0]);
                } catch (error) {
                    console.error('❌ Error al ejecutar el SP:', error.message);
                }
                break;

            case 'nuevo_prestamo':
                // Pedimos todos los datos necesarios para la transacción
                const datosPrestamo = await inquirer.prompt([
                    { type: 'input', name: 'nroLector', message: 'Nro de Lector:' },
                    { type: 'input', name: 'isbn', message: 'ISBN del libro (ej: 978-950-000001):' },
                    { type: 'input', name: 'nroEjemplar', message: 'Nro de Ejemplar (ej: 1):' },
                    { type: 'input', name: 'dias', message: '¿Por cuántos días se lo lleva?:' }
                ]);
                try {
                    // Calculamos la fecha de fin en base a los días
                    const fechaFin = new Date();
                    fechaFin.setDate(fechaFin.getDate() + parseInt(datosPrestamo.dias));
                    const fechaFinFormateada = fechaFin.toISOString().slice(0, 19).replace('T', ' ');

                    // Llamamos al SP transaccional
                    await connection.execute('CALL SP_Registrar_Nuevo_Prestamo(?, ?, ?, ?)', [
                        datosPrestamo.nroLector, 
                        fechaFinFormateada, 
                        datosPrestamo.isbn, 
                        datosPrestamo.nroEjemplar
                    ]);
                    console.log('✅ ¡Préstamo registrado con éxito!');

                } catch (error) {
                    // ACÁ ATRAPAMOS EL TRIGGER DE MOROSIDAD
                    // Si el error es el código '45000' que configuraron en TriggerMorosidad.sql
                    if(error.sqlState === '45000') {
                        console.error('\n🚨 BLOQUEADO POR EL SISTEMA 🚨');
                        console.error(error.message); // Imprime: "Operación denegada: El lector posee préstamos vencidos..."
                    } else {
                        console.error('❌ Error en la transacción:', error.message);
                    }
                }
                break;

            case 'consultas':
                try {
                    const [rows] = await connection.execute('SHOW TABLES;');
                    console.table(rows);
                } catch (error) {
                    console.error('❌ Error:', error.message);
                }
                break;

            case 'salir':
                console.log('¡Hasta luego!');
                salir = true;
                break;
        }
    }
}

async function startApp() {
    let connection;
    try {
        connection = await mysql.createConnection(dbConfig);
        console.log('✅ Conexión a la base de datos establecida.\n');
        await mainMenu(connection);
    } catch (error) {
        console.error('❌ Error conectando a MySQL:', error.message);
    } finally {
        if (connection) {
            await connection.end();
        }
    }
}

startApp();