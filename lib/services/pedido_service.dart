import 'package:cloud_firestore/cloud_firestore.dart';

class PedidoService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> salvarPedido(double total, List<String> produtos) async {
    try {
      print("Salvando pedido no Firestore...");

      await _db.collection("pedidos").add({
        "total": total,
        "produtos": produtos,
        "data": DateTime.now(),
        "status": "pendente",
      });

      print("Pedido salvo no Firestore!");
    } catch (e) {
      print("Erro ao salvar pedido no Firestore: $e");
      throw e; // Repassa o erro para o botão tratar
    }
  }
}
