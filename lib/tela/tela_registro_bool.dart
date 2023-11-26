import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto1/tela/tela_cadastrar_usuario.dart';
import 'package:flutter_projeto1/tela/tela_consulta.dart';
import 'package:flutter_projeto1/tela/tela_home.dart';
import '../componentes/bottom_nav_bar.dart';
import '../model/registro_global_model.dart';
import 'tela_registro_entrada.dart';
import 'tela_registro_saida.dart';

class TelaRegistroBool extends StatefulWidget {
  const TelaRegistroBool({Key? key}) : super(key: key);

  @override
  _TelaRegistroBoolState createState() => _TelaRegistroBoolState();
}

class _TelaRegistroBoolState extends State<TelaRegistroBool> {
  TipoMovimentacao tipoMovimentacao = TipoMovimentacao.entrada;
  int _selectedIndex = 0;

  void registrarMovimentacao(RegistroModel movimentacao) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Movimentação Registrada'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Dados da Movimentação:'),
              const SizedBox(height: 8),
              Text('Tipo de Movimentação: ${movimentacao.tipoMovimentacao}'),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 87, 150, 92),
        title: const Text("Manuseio Vegetal"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Navigator.of(context).pop();}),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              width: 200, // Largura desejada para a caixa de seleção
              child: DropdownButton<TipoMovimentacao>(
                value: tipoMovimentacao,
                underline: Container(), // Remove o sublinhado do texto selecionado
                onChanged: (value) {
                  setState(() {
                    tipoMovimentacao = value!;
                  });
                },
                items: [
                  DropdownMenuItem<TipoMovimentacao>(
                    value: TipoMovimentacao.entrada,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1, // Largura da borda
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Entrada',
                          style: TextStyle(
                            fontSize: 16,
                             // fontWeight: tipoMovimentacao == TipoMovimentacao.entrada ? FontWeight.bold : FontWeight.normal, // Destaca o item selecionado
                          ),
                        ),
                      ),
                    ),
                  ),
                  DropdownMenuItem<TipoMovimentacao>(
                    value: TipoMovimentacao.saida,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1, // Largura da borda
                          ),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Saída',
                          style: TextStyle(
                            fontSize: 16,

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (tipoMovimentacao == TipoMovimentacao.entrada) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TelaRegistroEntrada(
                        onRegistrarMovimentacao: registrarMovimentacao,
                      ),
                    ),
                  );
                } else {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => TelaRegistroSaida(
                        onRegistrarMovimentacao: registrarMovimentacao,
                      ),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                elevation: 20,
                shadowColor: Colors.black54,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Confirmar Escolha'),
            ),
          ],
        ),



      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onSignOut: _signOut,
      ),

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
            MaterialPageRoute(builder: (context) => const TelaRegistroBool()),
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
