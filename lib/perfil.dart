import 'package:flutter/material.dart';
import 'package:projeto_barbearia/home.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F1EA),

      appBar: AppBar(
        backgroundColor: Color(0xFF3A2A24),
        foregroundColor: Colors.white,
        toolbarHeight: 65,

        leading: Positioned(
          left: 20,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),

        title: Text(
          'Perfil',
          style: TextStyle(
            fontFamily: 'Lora',
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Column(
          children: [
/* 
            Container(
              height: 80,
              color: const Color(0xFF3D2A24),

              child: Stack(
                alignment: Alignment.center,
                children: [
                  // BOTÃO VOLTAR
                  Positioned(
                    left: 14,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),

                  // TÍTULO
                  const Text(
                    'Perfil',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Georgia',
                    ),
                  ),
                ],
              ),
            ), 
*/

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 12),

                    // CONFIGURAÇÕES
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 14,
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Tela de configurações
                          },
                          icon: const Icon(
                            Icons.settings_outlined,
                            size: 34,
                            color: Color(0xFF292929),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // FOTO DO USUÁRIO
                    const CircleAvatar(
                      radius: 75,
                      backgroundColor: Color(0xFFD9D9D9),

                      // Quando tiver uma foto:
                      // backgroundImage:
                      //     NetworkImage('URL_DA_FOTO'),
                    ),

                    const SizedBox(height: 20),

                    // NOME
                    const Text(
                      'Nome do Usuário',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Georgia',
                        color: Color(0xFF1F1F1F),
                      ),
                    ),

                    const SizedBox(height: 52),

                    // =========================
                    // CARD DOS HORÁRIOS
                    // =========================
                    Container(
                      width: 340,
                      padding: const EdgeInsets.fromLTRB(
                        16,
                        12,
                        16,
                        20,
                      ),

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),

                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [
                          const Text(
                            'Horários agendados:',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Georgia',
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            '27/09/2026 - 16:00',
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Georgia',
                            ),
                          ),

                          const SizedBox(height: 66),

                          // BOTÃO
                          Center(
                            child: SizedBox(
                              width: 200,
                              height: 40,

                              child: ElevatedButton(
                                onPressed: () {
                                  // Ir para agendamento
                                },

                                style:
                                    ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFFD16A3D),

                                  foregroundColor:
                                      Colors.white,

                                  elevation: 0,

                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                ),

                                child: const Text(
                                  'Agendar horário',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'Georgia',
                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          }

//        if (index == 1) {
//          Navigator.pushReplacement(
//            context,
//            MaterialPageRoute(
//              builder: (context) => const Agendamento(),
//            ),
//          );
//        }

        },

        selectedItemColor: const Color(0xFFC96A3D),
        unselectedItemColor: Color(0xFF77736B),
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            activeIcon: Icon(Icons.calendar_today),
            label: 'Agendamento',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}