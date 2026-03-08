import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HistoricoPage extends StatelessWidget {
  const HistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text("Meus Pedidos")),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("pedidos")
            .where("usuario", isEqualTo: user!.uid)
            .snapshots(),

        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final pedidos = snapshot.data!.docs;

          if (pedidos.isEmpty) {
            return const Center(child: Text("Nenhum pedido encontrado"));
          }

          return ListView.builder(
            itemCount: pedidos.length,
            itemBuilder: (context, index) {
              final pedido = pedidos[index];
              final produtos = List<String>.from(pedido['produtos']);

              return Card(
                child: ListTile(
                  title: Text("Pedido R\$ ${pedido['total']}"),
                  subtitle: Text(produtos.join(", ")),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
