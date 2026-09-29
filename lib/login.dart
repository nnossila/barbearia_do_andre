import 'package:flutter/material.dart';
import 'main.dart';
import 'cadastro.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final cpfController = TextEditingController();
  final senhaController = TextEditingController();

  bool carregando = false;

  Future<void> fazerLogin() async {
    final cpf = cpfController.text.trim();
    final senha = senhaController.text.trim();

    // Verifica se os campos estão preenchidos
    if (cpf.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha o CPF e a senha.')),
      );

      return;
    }

    setState(() {
      carregando = true;
    });

    try {
      // Procura o usuário no Supabase
      final usuario = await supabase
          .from('clientes')
          .select('id, cliente, cpf')
          .eq('cpf', cpf)
          .eq('senha', senha)
          .maybeSingle();

      if (!mounted) return;

      if (usuario == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('CPF ou senha incorretos.')),
        );

        return;
      }

      // Salva Login
      final prefs = await SharedPreferences.getInstance();

      await prefs.setBool('logado', true);
      await prefs.setInt('usuario_id', usuario['id']);
      await prefs.setString('usuario_nome', usuario['cliente']);
      await prefs.setString('usuario_cpf', usuario['cpf']);

      // Login realizado
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bem-vindo, ${usuario['cliente']}!')),
      );

      // ------------------------------------------------
      // COLOQUE AQUI A TELA PRINCIPAL DO SEU APP
      // ------------------------------------------------
      //
      // Exemplo:
      //
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => const Home(),
      //   ),
      // );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao fazer login: $e')));
    } finally {
      if (mounted) {
        setState(() {
          carregando = false;
        });
      }
    }
  }

  @override
  void dispose() {
    cpfController.dispose();
    senhaController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),

      body: Center(
        child: Container(
          width: 310,
          height: 690,
          color: const Color(0xFFF5F1E9),

          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: 270,

                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius: BorderRadius.circular(18),

                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // TÍTULO
                    const Text(
                      'Faça seu login',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Georgia',
                      ),
                    ),

                    const SizedBox(height: 10),

                    // LINHA
                    const Divider(color: Colors.black54, thickness: 1),

                    const SizedBox(height: 12),

                    // CPF
                    campo(
                      controller: cpfController,
                      hint: 'CPF',
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 14),

                    // SENHA
                    campo(
                      controller: senhaController,
                      hint: 'Senha',
                      obscureText: true,
                    ),

                    const SizedBox(height: 16),

                    // LINK PARA CADASTRO
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Text(
                            'Não tem um cadastro? ',
                            style: TextStyle(fontSize: 10),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Cadastro(),
                                ),
                              );
                            },

                            child: const Text(
                              'Se cadastre',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // BOTÃO LOGIN
                    SizedBox(
                      width: double.infinity,
                      height: 32,

                      child: ElevatedButton(
                        onPressed: carregando ? null : fazerLogin,

                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFD06A3D),

                          foregroundColor: Colors.white,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),

                          elevation: 0,
                        ),

                        child: carregando
                            ? const SizedBox(
                                width: 18,
                                height: 18,

                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Fazer login',
                                style: TextStyle(
                                  fontFamily: 'Georgia',
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // CAMPO DE TEXTO
  Widget campo({
    required TextEditingController controller,
    required String hint,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      height: 28,

      child: TextField(
        controller: controller,

        obscureText: obscureText,

        keyboardType: keyboardType,

        style: const TextStyle(fontSize: 11),

        decoration: InputDecoration(
          hintText: hint,

          hintStyle: const TextStyle(fontSize: 11, color: Colors.black87),

          filled: true,

          fillColor: const Color(0xFFE3DED4),

          contentPadding: const EdgeInsets.symmetric(horizontal: 12),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),

            borderSide: const BorderSide(color: Colors.black54),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),

            borderSide: const BorderSide(color: Colors.black54),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),

            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
