import 'package:flutter/material.dart';

class TelaListagem extends StatefulWidget {
  const TelaListagem({Key? key}) : super(key: key);

  @override
  State<TelaListagem> createState() => _TelaListagemState();
}

class _TelaListagemState extends State<TelaListagem> {
  Color topColor = Color.fromARGB(255, 2, 159, 212);
  Color bottomColor = Color.fromARGB(255, 168, 227, 247);
  String tipoSelecionado = '';

  Map<String, bool> botoesSelecionados = {
    'Borra': false,
    'Doação': false,
    'Empréstimo': false,
    'Fermentado': false,
    'Preparo': false,
    'Recozimento': false,
    'Retorno Sessão': false,
  };

  void _selecionarTipo(String tipo) {
    setState(() {
      tipoSelecionado = tipo;
      botoesSelecionados.forEach((key, value) {
        botoesSelecionados[key] = key == tipo;
      });
    });
    /// lógica de transição
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Selecione o tipo desejado',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: topColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
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
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              _buildTipoButton('Borra', Icons.recycling),
              SizedBox(height: 8.0),
              _buildTipoButton('Doação', Icons.favorite),
              SizedBox(height: 8.0),
              _buildTipoButton('Empréstimo', Icons.swap_horiz),
              SizedBox(height: 8.0),
              _buildTipoButton('Fermentado', Icons.bubble_chart),
              SizedBox(height: 8.0),
              _buildTipoButton('Preparo', Icons.groups),
              SizedBox(height: 8.0),
              _buildTipoButton('Recozimento', Icons.whatshot),
              SizedBox(height: 8.0),
              _buildTipoButton('Retorno Sessão', Icons.change_circle),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
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
        primary: (botoesSelecionados[tipo] ?? false) ? Colors.orangeAccent : Color.fromARGB(255, 2, 159, 212),
        onPrimary: Colors.white,
        textStyle: TextStyle(fontSize: 25.0),
        side: BorderSide(color: Colors.white),
      ),
      icon: Icon(icon),
      label: Text(tipo),
    );
  }

  void _onItemTapped(int index) {
    ///logica da barra
    setState(() {
      _selectedIndex = index;
    });
  }
}
