import inquirer from 'inquirer';
import mysql from 'mysql2/promise';

// Configuración de la conexión a la base de datos 
const dbConfig = {
    host: 'localhost',
    user: 'root',
    password: 'root123',      
    database: 'biblioteca_db'  
};

async function mainMenu(connection) {
    let salir = false;

    while (!salir) {
        const { opcion } = await inquirer.prompt([
            {
                type: 'select',
                name: 'opcion',
                message: '📚 Sistema de Gestión de Biblioteca - ¿Qué deseas hacer?',
                choices: [
                    { name: '1. Ver las tablas de la base de datos', value: 'consultas' },
                    { name: '2. Salir', value: 'salir' }
                ]
            }
        ]);

        switch (opcion) {
            case 'consultas':
                try {
                    const [rows] = await connection.execute('SHOW TABLES;');
                    console.log('\nTablas en la base de datos:');
                    console.table(rows);
                    console.log('\n');
                } catch (error) {
                    console.error('Error al consultar la base de datos:', error.message);
                }
                break;
            case 'salir':
                console.log('¡Hasta luego!');
                salir = true;
                break;
        }
    }
}

// Inicialización de la aplicación
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