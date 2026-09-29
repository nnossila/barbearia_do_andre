import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    verificarLogin();
  }

  Future<void> verificarLogin() async {
    // Espera a splash aparecer
    await Future.delayed(
      const Duration(seconds: 2),
    );

    final prefs = await SharedPreferences.getInstance();

    final logado = prefs.getBool('logado') ?? false;

    if (!mounted) return;

    if (logado) {
      // Usuário já fez login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } else {
      // Usuário ainda não fez login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F1EA),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animação de carregar
            const CircularProgressIndicator(
              color: Color(0xFF24241F),
            ),
          ],
        ),
      ),
    );
  }
}