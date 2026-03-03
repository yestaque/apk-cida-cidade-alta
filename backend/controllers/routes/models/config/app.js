const express = require("express");
const cors = require("cors");

const app = express();
app.use(cors());
app.use(express.json());

app.use("/produtos", require("./routes/produtos"));
app.use("/pedidos", require("./routes/pedidos"));

module.exports = app;