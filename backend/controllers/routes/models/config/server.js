const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');

const produtoRoutes = require('./routes/produtos');

const app = express();
app.use(cors());
app.use(bodyParser.json());

app.use('/produtos', produtoRoutes);

app.get('/', (req,res)=>res.send('Backend Loja Bazar ativo!'));

app.listen(3000,()=>console.log('Servidor rodando na porta 3000'));