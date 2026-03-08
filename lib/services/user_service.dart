import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {

  final db = FirebaseFirestore.instance;

  salvarUsuario(String nome, String email) async {

    final user = FirebaseAuth.instance.currentUser;

    await db.collection("usuarios").doc(user!.uid).set({
      "nome": nome,
      "email": email,
      "data": DateTime.now(),
    });

  }

}