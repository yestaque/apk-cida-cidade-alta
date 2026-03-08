import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  final nome = TextEditingController();
  final preco = TextEditingController();

  salvarProduto() async {

    await FirebaseFirestore.instance.collection("produtos").add({
      "nome": nome.text,
      "preco": double.parse(preco.text),
      "data": DateTime.now(),
    });

    nome.clear();
    preco.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Produto adicionado")),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text("Painel Admin")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: nome,
              decoration: const InputDecoration(labelText: "Produto"),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: preco,
              decoration: const InputDecoration(labelText: "Preço"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: salvarProduto,
              child: const Text("Salvar Produto"),
            )

          ],
        ),
      ),
    );
  }
}