import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto1/tela/tela_cadastrar_usuario.dart';
import 'package:flutter_projeto1/tela/tela_consulta.dart';
import 'package:flutter_projeto1/tela/tela_home.dart';
import 'package:flutter_projeto1/tela/tela_registro.dart';

class TelaBase extends StatefulWidget {
  const TelaBase({Key? key}) : super(key: key);

  @override
  _TelaBaseState createState() => _TelaBaseState();
}

class _TelaBaseState extends State<TelaBase> {
  int _selectedIndex = 0;
  Color topColor = const Color.fromARGB(255, 101, 128, 51);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 87, 150, 92),
    title: const Text(''),
    leading: IconButton(
    icon: Icon(Icons.arrow_back,color: Colors.white,),
    onPressed: () {
    Navigator.of(context).pop();
    },
    ),
      ),
      body: Center(
        child: Text('Conteúdo da tela $_selectedIndex'),
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
