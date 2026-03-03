const Produto = require('../models/produto');

const getProdutos = async (req,res) => {
  try { res.json(await Produto.getAll()); }
  catch(e){ res.status(500).json({error:e.message}); }
};

const getProdutoById = async (req,res) => {
  try {
    const produto = await Produto.getById(req.params.id);
    if(!produto) return res.status(404).json({error:'Produto não encontrado'});
    res.json(produto);
  } catch(e){ res.status(500).json({error:e.message}); }
};

module.exports = { getProdutos, getProdutoById };