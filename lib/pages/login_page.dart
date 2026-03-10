import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../pages/register_page.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final email = TextEditingController();
  final senha = TextEditingController();

  final auth = AuthService();

  login() async {

    await auth.login(email.text, senha.text);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const AppPrincipal()),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: senha,
              decoration: const InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: login,
              child: const Text("Entrar"),
            ),
            

           TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage(),
      ),
    );
  },
  child: Text("Cadastrar"),
)

          ],
        ),
      ),
    );
  }
}
