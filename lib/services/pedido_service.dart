import 'package:cloud_firestore/cloud_firestore.dart';

class PedidoService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> salvarPedido(double total, List<String> produtos) async {
    try {
      await _db.collection("pedidos").add({
        "total": total,
        "produtos": produtos,
        "data": Timestamp.now(), // melhor para Firestore
        "status": "pendente",
      }).timeout(const Duration(seconds: 10));

      print("Pedido salvo com sucesso");
    } catch (e) {
      print("Erro ao salvar pedido: $e");
      rethrow;
    }
  }
}