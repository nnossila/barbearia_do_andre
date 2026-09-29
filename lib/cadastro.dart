import 'package:flutter/material.dart';
import 'main.dart';
import 'login.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final senhaController = TextEditingController();

  bool carregando = false;

  Future<void> fazerCadastro() async {
    final nome = nomeController.text.trim();
    final cpf = cpfController.text.trim();
    final senha = senhaController.text.trim();

    // Verifica os campos
    if (nome.isEmpty || cpf.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos.'),
        ),
      );

      return;
    }

    setState(() {
      carregando = true;
    });

    try {
      // Verifica se o CPF já existe
      final existente = await supabase
          .from('clientes')
          .select('id')
          .eq('cpf', cpf)
          .maybeSingle();

      if (!mounted) return;

      if (existente != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Este CPF já está cadastrado.',
            ),
          ),
        );

        return;
      }

      // Cadastra no Supabase
      await supabase.from('clientes').insert({
        'cliente': nome,
        'cpf': cpf,
        'senha': senha,
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Cadastro realizado com sucesso!',
          ),
        ),
      );

      // Limpa os campos
      nomeController.clear();
      cpfController.clear();
      senhaController.clear();

      // Vai para o Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Erro ao cadastrar: $e',
          ),
        ),
      );
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
    nomeController.dispose();
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
                      'Faça seu cadastro',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Georgia',
                      ),
                    ),

                    const SizedBox(height: 10),

                    // LINHA
                    const Divider(
                      color: Colors.black54,
                      thickness: 1,
                    ),

                    const SizedBox(height: 12),

                    // NOME
                    campo(
                      controller: nomeController,
                      hint: 'Nome completo',
                    ),

                    const SizedBox(height: 14),

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

                    // LINK PARA LOGIN
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Text(
                            'Já tem um cadastro? ',
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const Login(),
                                ),
                              );
                            },

                            child: const Text(
                              'Faça seu login',
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

                    // BOTÃO CADASTRO
                    SizedBox(
                      width: double.infinity,
                      height: 32,

                      child: ElevatedButton(
                        onPressed:
                            carregando
                                ? null
                                : fazerCadastro,

                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFD06A3D),

                          foregroundColor: Colors.white,

                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20),
                          ),

                          elevation: 0,
                        ),

                        child: carregando
                            ? const SizedBox(
                                width: 18,
                                height: 18,

                                child:
                                    CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Fazer cadastro',
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

        style: const TextStyle(
          fontSize: 11,
        ),

        decoration: InputDecoration(
          hintText: hint,

          hintStyle: const TextStyle(
            fontSize: 11,
            color: Colors.black87,
          ),

          filled: true,

          fillColor: const Color(0xFFE3DED4),

          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 12,
          ),

          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),

            borderSide: const BorderSide(
              color: Colors.black54,
            ),
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),

            borderSide: const BorderSide(
              color: Colors.black54,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(12),

            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}