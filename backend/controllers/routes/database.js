const { Pool } = require("pg");

const pool = new Pool({
  user: "postgres",
  host: "localhost",
  database: "loja_bazar",
  password: "SUA_SENHA",
  port: 5432,
});

module.exports = pool;