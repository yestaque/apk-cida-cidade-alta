import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/carrinho.dart';

class CheckoutPixPage extends StatelessWidget {
  const CheckoutPixPage({super.key});

  salvarPedido() async {

    final user = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection("pedidos").add({

      "usuario": user!.uid,
      "total": Carrinho.total(),
      "produtos": Carrinho.itens.map((e) => e['nome']).toList(),
      "data": DateTime.now(),

    });

  }

  @override
  Widget build(BuildContext context) {

    final total = Carrinho.total();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagamento PIX"),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            "Total: R\$ $total",
            style: const TextStyle(fontSize: 22),
          ),

          const SizedBox(height: 20),

          QrImageView(
            data: "PIX $total",
            size: 250,
          ),

          const SizedBox(height: 20),

          ElevatedButton(
            child: const Text("Confirmar Pagamento"),

            onPressed: () async {

              await salvarPedido();

              Carrinho.itens.clear();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Pedido realizado"),
                ),
              );

              Navigator.pop(context);

            },
          )

        ],
      ),
    );
  }
}