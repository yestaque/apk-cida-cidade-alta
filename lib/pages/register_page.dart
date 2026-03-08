import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/user_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();

  final auth = AuthService();

 register() async {

  try {

    await auth.register(
      email.text,
      senha.text,
    );

    final userService = UserService();

    await userService.salvarUsuario(
      nome.text,
      email.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Conta criada com sucesso")),
    );

    Navigator.pop(context);

  } catch (e) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Erro: $e")),
    );

  }

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar conta"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: nome,
              decoration: const InputDecoration(
                labelText: "Nome",
                prefixIcon: Icon(Icons.person),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: email,
              decoration: const InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: senha,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Senha",
                prefixIcon: Icon(Icons.lock),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: register,
                child: const Text("Cadastrar"),
              ),
            )

          ],
        ),
      ),
    );
  }
}