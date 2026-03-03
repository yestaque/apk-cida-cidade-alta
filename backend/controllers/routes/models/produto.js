const pool = require('../config/db');

const Produto = {
  getAll: async () => (await pool.query('SELECT * FROM produtos')).rows,
  getById: async (id) => (await pool.query('SELECT * FROM produtos WHERE id=$1', [id])).rows[0],
  create: async ({nome, preco, imagem, descricao, estoque}) => {
    const res = await pool.query(
      'INSERT INTO produtos (nome, preco, imagem, descricao, estoque) VALUES ($1,$2,$3,$4,$5) RETURNING *',
      [nome, preco, imagem, descricao, estoque]
    );
    return res.rows[0];
  }
};

module.exports = Produto;