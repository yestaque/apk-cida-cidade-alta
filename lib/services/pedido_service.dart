import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PedidoService {

  final db = FirebaseFirestore.instance;

  salvarPedido(double total, List produtos) async {

    final user = FirebaseAuth.instance.currentUser;

    await db.collection("pedidos").add({
      "usuario": user!.uid,
      "total": total,
      "produtos": produtos,
      "data": DateTime.now(),
    });

  }

}