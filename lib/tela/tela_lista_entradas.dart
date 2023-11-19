import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto1/formulario_dinamico.dart';
import 'package:flutter_projeto1/tela/tela_cadastrar_usuario.dart';
import 'package:flutter_projeto1/tela/tela_login.dart'; // Importe a tela de login

import 'enum_bar.dart';

class TelaListagem extends StatefulWidget {
  const TelaListagem({Key? key}) : super(key: key);

  @override
  State<TelaListagem> createState() => _TelaListagemState();
}

class _TelaListagemState extends State<TelaListagem> {
  Color topColor = const Color.fromARGB(255, 2, 159, 212);
  Color bottomColor = const Color.fromARGB(255, 168, 227, 247);
  String tipoSelecionado = '';

  Map<String, bool> botoesSelecionados = {
    'Borra': false,
    'Doação': false,
    'Empréstimo': false,
    'Fermentado': false,
    'Preparo': false,
    'Recozimento': false,
    'Sessão': false,
  };

  void _selecionarTipo(String tipo) {
    setState(() {
      tipoSelecionado = tipo;
      botoesSelecionados.forEach((key, value) {
        botoesSelecionados[key] = key == tipo;
      });
    });

    if (tipoSelecionado.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormularioDinamico(
            tipoSelecionado: tipoSelecionado,
          ),
        ),
      );
    }
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Selecione o tipo desejado',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: topColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [topColor, bottomColor],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16.0),
              _buildTipoButton('Borra', Icons.recycling),
              const SizedBox(height: 8.0),
              _buildTipoButton('Doação', Icons.favorite),
              const SizedBox(height: 8.0),
              _buildTipoButton('Empréstimo', Icons.swap_horiz),
              const SizedBox(height: 8.0),
              _buildTipoButton('Fermentado', Icons.bubble_chart),
              const SizedBox(height: 8.0),
              _buildTipoButton('Preparo', Icons.groups),
              const SizedBox(height: 8.0),
              _buildTipoButton('Recozimento', Icons.whatshot),
              const SizedBox(height: 8.0),
              _buildTipoButton('Sessão', Icons.change_circle),
              const SizedBox(height: 16.0),
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

  Widget _buildTipoButton(String tipo, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () => _selecionarTipo(tipo),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: (botoesSelecionados[tipo] ?? false)
            ? Colors.orangeAccent
            : const Color.fromARGB(255, 2, 159, 212),
        textStyle: const TextStyle(fontSize: 25.0),
        side: const BorderSide(color: Colors.white),
      ),
      icon: Icon(icon),
      label: Text(tipo),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          Navigator.pushReplacementNamed(context, '/home');
          break;
        case 1:
          Navigator.pushReplacementNamed(context, '/registro');
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TelaCadastrarUsuario()),
          );
          break;
        case 3:
          Navigator.pushReplacementNamed(context, '/consulta');
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
