import 'package:flutter/material.dart';
import 'home.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navegarParaHome();
  }

  Future<void> _navegarParaHome() async {
    // tempo para que o splash fique visivel
    await Future.delayed(const Duration(seconds: 2),);
    // navegar para a tela principal
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage())
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