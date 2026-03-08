class Carrinho {

  static List<Map> itens = [];

  static double total() {

    double soma = 0;

    for (var p in itens) {
      soma += p['preco'];
    }

    return soma;
  }

}