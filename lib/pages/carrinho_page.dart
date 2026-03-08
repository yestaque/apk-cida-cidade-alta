import 'package:flutter/material.dart';
import '../models/carrinho.dart';
import 'checkout_pix_page.dart';

class CarrinhoPage extends StatelessWidget {
  const CarrinhoPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Carrinho"),
      ),

      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: Carrinho.itens.length,

              itemBuilder: (context, index) {

                final item = Carrinho.itens[index];

                return ListTile(
                  title: Text(item['nome']),
                  subtitle: Text("R\$ ${item['preco']}"),
                );
              },
            ),
          ),

          Text(
            "Total: R\$ ${Carrinho.total()}",
            style: const TextStyle(fontSize: 20),
          ),

          ElevatedButton(
            child: const Text("Pagar com PIX"),

            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CheckoutPixPage(),
                ),
              );

            },
          )

        ],
      ),
    );
  }
}