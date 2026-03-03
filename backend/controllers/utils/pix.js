function calcularCRC16(payload) {
  let crc = 0xFFFF;
  for (let i = 0; i < payload.length; i++) {
    crc ^= payload.charCodeAt(i) << 8;
    for (let j = 0; j < 8; j++) {
      crc = (crc & 0x8000) ? ((crc << 1) ^ 0x1021) : (crc << 1);
      crc &= 0xFFFF;
    }
  }
  return crc.toString(16).toUpperCase().padStart(4, '0');
}

function gerarPixDinamico({chavePix, nome, cidade, valor, idPedido}) {
  const valorFormatado = valor.toFixed(2);
  let payloadSemCRC = 
    "000201" +
    "26580014BR.GOV.BCB.PIX" +
    `01${chavePix.length.toString().padStart(2,'0')}${chavePix}` +
    "52040000" +
    "5303986" +
    `54${valorFormatado.length.toString().padStart(2,'0')}${valorFormatado}` +
    "5802BR" +
    `59${nome.length.toString().padStart(2,'0')}${nome}` +
    `60${cidade.length.toString().padStart(2,'0')}${cidade}` +
    `62${(idPedido.length+2).toString().padStart(2,'0')}01${idPedido}` +
    "6304";

  const crc = calcularCRC16(payloadSemCRC);
  return payloadSemCRC + crc;
}

module.exports = { gerarPixDinamico };