const { Pool } = require('pg');

const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'loja_bazar_novo',
    password: 'Mainha123',
    port: 5432,
});

module.exports = pool;