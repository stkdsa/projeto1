import 'package:flutter/material.dart';
import 'package:flutter_projeto1/tela/tela_base.dart';

class TelaConsulta extends TelaBase {
  @override
  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Tela de Consulta',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('Item $index'),
                subtitle: const Text('Detalhes do item'),
                onTap: () {
                  // Implemente a lógica de navegação ou ação ao clicar em um item
                },
              );
            },
          ),
        ),

      ],

    );

  }
}
