const express = require('express');
const router = express.Router();
const { getProdutos, getProdutoById } = require('../controllers/produtoController');

router.get('/', getProdutos);
router.get('/:id', getProdutoById);

module.exports = router;