  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto1/tela/tela_cadastrar_usuario.dart';
import 'package:flutter_projeto1/tela/tela_consulta.dart';
import 'package:flutter_projeto1/tela/tela_home.dart';

import '../model_movimentacao_vegetal.dart';
import '../model_vegetal_estoque.dart';

  class TelaRegistro extends StatefulWidget {
    const TelaRegistro({Key? key}) : super(key: key);

    @override
    _TelaRegistroState createState() => _TelaRegistroState();
  }

  class _TelaRegistroState extends State<TelaRegistro> {
    String? origem;
    String? mPreparo;
    String? mAuxiliar;
    String? mDirigente;
    String? mAssistente;
    double? litros;
    bool isEntrada = true;
    bool isFormVisible = false;
    Estoque estoque = Estoque();
    int _selectedIndex = 0;
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 87, 150, 92),
          title: const Text('Registro Manuseio Vegetal'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    const Text('Escolha o tipo:'),
                    const SizedBox(width: 8),
                    DropdownButton<bool>(
                      value: isEntrada,
                      onChanged: (value) {
                        setState(() {
                          isEntrada = value!;
                        });
                        if (value!) {
                          setState(() {
                            isFormVisible = true;
                          });
                        }
                      },
                      items: [
                        DropdownMenuItem<bool>(
                          value: true,
                          child: const Text('Entrada'),
                        ),
                        DropdownMenuItem<bool>(
                          value: false,
                          child: const Text('Saída'),
                        ),
                      ],
                    ),
                  ],
                ),
                Visibility(
                  visible: isFormVisible,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Origem'),
                        onChanged: (value) => origem = value,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Método de Preparo'),
                        onChanged: (value) => mPreparo = value,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Método Auxiliar'),
                        onChanged: (value) => mAuxiliar = value,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Método Dirigente'),
                        onChanged: (value) => mDirigente = value,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Método Assistente'),
                        onChanged: (value) => mAssistente = value,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Litros'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => litros = double.tryParse(value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(

                  onPressed: () {
                    if (isEntrada) {
                      if (origem != null) {
                        registrarMovimentacao();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Escolha o tipo antes de registrar.'),

                          ),
                        );
                      }
                    } else {
                      registrarMovimentacao();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.green,
                    elevation: 20,
                    shadowColor: Colors.black54,
                    padding: const EdgeInsets.symmetric(vertical: 15),),
                  child: const Text('Registrar Movimentação'),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: 'Registro',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add),
              label: 'Cadastro',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Consulta',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app),
              label: 'Sair',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),


      );
    }

    void registrarMovimentacao() {
      // Obtém os dados inseridos pelo usuário
      Map<String, dynamic> dadosMovimentacao = {
        'Origem': origem,
        'Método de Preparo': mPreparo,
        'Método Auxiliar': mAuxiliar,
        'Método Dirigente': mDirigente,
        'Método Assistente': mAssistente,
        'Litros': litros,
        'Tipo': isEntrada ? 'Entrada' : 'Saída',
      };

      // Substitui vírgulas por pontos e converte para double
      double? litrosDouble = litros != null ? double.tryParse(litros!.toString().replaceAll(',', '.')) : null;

      // Adiciona a movimentação ao estoque
      MovimentacaoVegetal movimentacao = MovimentacaoVegetal(
        origem: origem!,
        mPreparo: mPreparo,
        mAuxiliar: mAuxiliar,
        mDirigente: mDirigente,
        mAssistente: mAssistente,
        litros: litrosDouble,
        isEntrada: isEntrada,
      );
      estoque.adicionarMovimentacao(movimentacao);

      double saldoTotal = estoque.calcularTotalVegetal();


      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 8),
                Text('Movimentação Registrada'),
              ],
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Dados da Movimentação:'),
                        const Divider(height: 8, color: Colors.transparent),
                        for (var entry in dadosMovimentacao.entries)
                          Text('${entry.key}: ${entry.value}'),
                        const Divider(height: 8, color: Colors.transparent),
                        Text('Saldo Total no Estoque: $saldoTotal'),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),

            ],
          );
        },
      );
    }


    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;

        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TelaHome()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TelaRegistro()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TelaCadastrarUsuario()),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) =>  TelaConsulta()),
            );
            break;
          case 4:
            _signOut();
            break;
          default:
          // Adicione a lógica padrão, se necessário
        }
      });
    }

    void _signOut() async {
      try {
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, '/sair');
      } catch (e) {
        print('Erro ao fazer logout: $e');
      }
    }
  }
