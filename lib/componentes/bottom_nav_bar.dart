import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final Function() onSignOut;

  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.onSignOut,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color topColor = const Color.fromARGB(255, 101, 128, 51);
    return BottomNavigationBar(
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
      currentIndex: selectedIndex,
      selectedItemColor: topColor,
      unselectedItemColor: Colors.grey,
      onTap: onItemTapped,
    );
  }

}
