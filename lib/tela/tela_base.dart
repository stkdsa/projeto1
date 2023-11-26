import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto1/formulario_dinamico.dart';
import 'package:flutter_projeto1/tela/tela_cadastrar_usuario.dart';
import 'package:flutter_projeto1/tela/tela_consulta.dart';
import 'package:flutter_projeto1/tela/tela_home.dart';
import 'package:flutter_projeto1/tela/tela_login.dart';
import 'package:flutter_projeto1/tela/tela_registro_bool.dart';
import 'package:flutter_projeto1/tela/tela_registro_entrada.dart';
import '../componentes/bottom_nav_bar.dart';

class TelaBase extends StatefulWidget {
  const TelaBase({Key? key}) : super(key: key);

  @override
  _TelaBaseState createState() => _TelaBaseState();
}

class _TelaBaseState extends State<TelaBase> {
  int _selectedIndex = 0;
  Color topColor = const Color.fromARGB(255, 101, 128, 51);
  Color buttomColor = Color.fromARGB(255, 87, 150, 92);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttomColor,
        title: const Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Text('Conteúdo da tela $_selectedIndex'),
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
            MaterialPageRoute(builder: (context) => TelaConsulta()),
          );
          break;
        case 4:
          _signOut();
          break;
        default:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TelaLogin()),
          );
          break;
      }
    });
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TelaLogin()),
      );
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }
}


