import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

/* ================= APP ================= */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Loja de Bazar',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.dark,
        ),
      ),
      home: const AppPrincipal(),
    );
  }
}

/* ================= MODELOS ================= */
class Produto {
  final String nome;
  final double preco;
  final String imagem;

  Produto({required this.nome, required this.preco, required this.imagem});
}

class Avaliacao {
  final String usuario;
  final int estrelas;
  final String comentario;

  Avaliacao({
    required this.usuario,
    required this.estrelas,
    required this.comentario,
  });
}

class DonoLoja {
  final String nome;
  final String estado;
  final String telefone;
  final String email;
  final String descricao;
  final int idade;

  DonoLoja({
    required this.nome,
    required this.estado,
    required this.telefone,
    required this.email,
    required this.descricao,
    required this.idade,
  });
}

/* ================= DADOS ================= */
final List<Produto> produtos = [
  Produto(
    nome: 'Vestido',
    preco: 25,
    imagem: 'assets/img/woman-2537564_1280.jpg',
  ),
  Produto(
    nome: 'Vestidos',
    preco: 20,
    imagem: 'assets/img/woman-6115105_1280.jpg',
  ),
  Produto(
    nome: 'Roupas de bazar',
    preco: 20,
    imagem: 'assets/img/bazaar-2835796_1920.jpg',
  ),
  Produto(
    nome: 'Corte Masculino',
    preco: 20,
    imagem: 'assets/img/homem-de-vista-lateral-cortando-o-cabelo.jpg',
  ),
  Produto(
    nome: 'Corte Feminino',
    preco: 20,
    imagem: 'assets/img/mulher-fazendo-tratamento-em-cabeleireiro.jpg',
  ),
  Produto(
    nome: 'Hidratação',
    preco: 50,
    imagem: 'assets/img/spa-4481538_1280.jpg',
  ),
  Produto(
    nome: 'Escova',
    preco: 50,
    imagem: 'assets/img/haircut-834280_1280.jpg',
  ),
  Produto(
    nome: 'Mão e pé',
    preco: 50,
    imagem: 'assets/img/people-2587157_1280.jpg',
  ),
];

List<Produto> carrinho = [];
Set<Produto> favoritos = {};
Map<Produto, int> quantidade = {};
Map<Produto, List<Avaliacao>> avaliacoes = {};

final dono = DonoLoja(
  nome: 'Gabriel Freire Bacelar',
  estado: 'Rio Grande do Norte',
  telefone: '+55 84 99216-0269',
  email: 'gabrielbacelar1000@gmail.com',
  descricao:
      'Sou desenvolvedor web, mobile e design 3D. Desenvolvi esta loja de bazar virtual para venda de roupas e salão de beleza. Eu vendo sites, aplicativos móveis e design 3d para e-commerce faço um preço ótimo! Entre em contato comigo para saber sobre nossos serviços!',
  idade: 22,
);

/* ================= APP PRINCIPAL ================= */
class AppPrincipal extends StatefulWidget {
  const AppPrincipal({super.key});

  @override
  State<AppPrincipal> createState() => _AppPrincipalState();
}

class _AppPrincipalState extends State<AppPrincipal> {
  int index = 0;

  final titulos = ['Home', 'Loja 🛍️', 'Carrinho 🛒'];

  @override
  Widget build(BuildContext context) {
    final telas = [
      const HomePage(),
      LojaPage(
        onAddCarrinho: (p) {
          setState(() {
            carrinho.add(p);
            quantidade[p] = (quantidade[p] ?? 0) + 1;
          });
        },
        onToggleFavorito: (p) {
          setState(() {
            favoritos.contains(p) ? favoritos.remove(p) : favoritos.add(p);
          });
        },
      ),
      CarrinhoPage(onUpdate: () => setState(() {})),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(titulos[index])),
      body: telas[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => setState(() => index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Loja'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Carrinho',
          ),
        ],
      ),
    );
  }
}

/* ================= HOME ================= */
class CarouselHome extends StatefulWidget {
  const CarouselHome({super.key});

  @override
  State<CarouselHome> createState() => _CarouselHomeState();
}

class _CarouselHomeState extends State<CarouselHome> {
  final PageController controller = PageController();
  int indexAtual = 0;

  final List<String> imagens = [
    'https://picsum.photos/800/400?1',
    'https://picsum.photos/800/400?2',
    'https://picsum.photos/800/400?3',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PageView.builder(
            controller: controller,
            itemCount: imagens.length,
            onPageChanged: (i) {
              setState(() => indexAtual = i);
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imagens[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            imagens.length,
            (i) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: indexAtual == i ? 12 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: indexAtual == i ? Colors.purple : Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const CarouselHome(),
        const SizedBox(height: 20),
        const ClockDateWidget(),
        const SizedBox(height: 20),
        const Text(
          'Bem-vindo à Loja de Bazar e Salão de Beleza!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PerfilDonoPage()),
            );
          },
          child: const Text('Sobre o Desenvolvedor do Aplicativo'),
        ),
      ],
    );
  }
}

/* ================= RELÓGIO ================= */
class ClockDateWidget extends StatefulWidget {
  const ClockDateWidget({super.key});

  @override
  State<ClockDateWidget> createState() => _ClockDateWidgetState();
}

class _ClockDateWidgetState extends State<ClockDateWidget> {
  late Timer timer;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => now = DateTime.now());
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${now.day}/${now.month}/${now.year}',
          style: const TextStyle(fontSize: 18),
        ),
        Text(
          '${now.hour}:${now.minute}:${now.second}',
          style: const TextStyle(fontSize: 28),
        ),
      ],
    );
  }
}

/* ================= LOJA ================= */
class LojaPage extends StatefulWidget {
  final Function(Produto) onAddCarrinho;
  final Function(Produto) onToggleFavorito;

  const LojaPage({
    super.key,
    required this.onAddCarrinho,
    required this.onToggleFavorito,
  });

  @override
  State<LojaPage> createState() => _LojaPageState();
}

class _LojaPageState extends State<LojaPage> {
  String busca = '';

  @override
  Widget build(BuildContext context) {
    final listaFiltrada = produtos
        .where((p) => p.nome.toLowerCase().contains(busca.toLowerCase()))
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Buscar produtos...',
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => setState(() => busca = v),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: listaFiltrada.length,
            itemBuilder: (_, i) {
              final p = listaFiltrada[i];

              return Card(
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Image.asset(
                            p.imagem,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: IconButton(
                              icon: Icon(
                                favoritos.contains(p)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () => widget.onToggleFavorito(p),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            p.nome,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('R\$ ${p.preco.toStringAsFixed(2)}'),
                          ElevatedButton(
                            onPressed: () {
                              widget.onAddCarrinho(p);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Adicionado ao carrinho'),
                                ),
                              );
                            },
                            child: const Text('Adicionar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/* ================= CARRINHO ================= */
class CarrinhoPage extends StatefulWidget {
  final VoidCallback onUpdate;
  const CarrinhoPage({super.key, required this.onUpdate});

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  @override
  Widget build(BuildContext context) {
    if (carrinho.isEmpty) {
      return const Center(child: Text('Carrinho vazio'));
    }

    double total = carrinho.fold(
      0,
      (s, p) => s + (p.preco * (quantidade[p] ?? 1)),
    );

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: carrinho.length,
            itemBuilder: (_, i) {
              final p = carrinho[i];
              quantidade[p] ??= 1;

              return ListTile(
                leading: Image.asset(p.imagem, width: 50, fit: BoxFit.cover),
                title: Text(p.nome),
                subtitle: Text(
                  'R\$ ${(p.preco * quantidade[p]!).toStringAsFixed(2)}',
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Total: R\$ ${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CheckoutPixPage()),
                  );
                },
                child: const Text('Pagar com PIX'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/* ================= CHECKOUT ================= */
class CheckoutPixPage extends StatelessWidget {
  const CheckoutPixPage({super.key});

  @override
  Widget build(BuildContext context) {
    double total = carrinho.fold(
      0,
      (s, p) => s + (p.preco * (quantidade[p] ?? 1)),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Pagamento PIX')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.qr_code, size: 120),
            Text(
              'Total: R\$ ${total.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const SelectableText('84992160269'),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                carrinho.clear();
                quantidade.clear();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pedido finalizado!')),
                );
              },
              child: const Text('Finalizar Pedido'),
            ),
          ],
        ),
      ),
    );
  }
}

/* ================= PERFIL ================= */
class PerfilDonoPage extends StatelessWidget {
  const PerfilDonoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre o Desenvolvedor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${dono.nome}'),
            Text('Idade: ${dono.idade}'),
            Text('Estado: ${dono.estado}'),
            Text('Telefone: ${dono.telefone}'),
            Text('Email: ${dono.email}'),
            const SizedBox(height: 16),
            Text(dono.descricao),
          ],
        ),
      ),
    );
  }
}
