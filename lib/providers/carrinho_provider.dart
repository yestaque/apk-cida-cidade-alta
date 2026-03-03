import 'package:flutter/material.dart';
import '../models/produto.dart';

class CarrinhoProvider with ChangeNotifier {
  final Map<Produto, int> _itens = {};

  Map<Produto, int> get itens => _itens;

  void adicionar(Produto produto) {
    _itens[produto] = (_itens[produto] ?? 0) + 1;
    notifyListeners();
  }

  void remover(Produto produto) {
    if (_itens.containsKey(produto)) {
      if (_itens[produto]! > 1) {
        _itens[produto] = _itens[produto]! - 1;
      } else {
        _itens.remove(produto);
      }
      notifyListeners();
    }
  }

  double get total {
    double soma = 0;
    _itens.forEach((produto, quantidade) {
      soma += produto.preco * quantidade;
    });
    return soma;
  }

  void limpar() {
    _itens.clear();
    notifyListeners();
  }
}