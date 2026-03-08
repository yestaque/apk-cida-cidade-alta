import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/carrinho.dart';

class LojaPage extends StatelessWidget {
  const LojaPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Loja"),
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("produtos")
            .snapshots(),

        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final produtos = snapshot.data!.docs;

          return ListView.builder(
            itemCount: produtos.length,
            itemBuilder: (context, index) {

              final p = produtos[index];

              return Card(
                child: ListTile(
                  title: Text(p['nome']),
                  subtitle: Text("R\$ ${p['preco']}"),

                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),

                    onPressed: () {

                      Carrinho.itens.add({
                        "nome": p['nome'],
                        "preco": p['preco'],
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Adicionado ao carrinho"),
                        ),
                      );

                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}