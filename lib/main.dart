import 'package:flutter/material.dart';
import 'package:flutter_projeto1/tela/tela_cadastrar_usuario.dart';
import 'package:flutter_projeto1/tela/tela_inicial.dart';
import 'package:flutter_projeto1/tela/tela_lista_entradas.dart';
import 'package:flutter_projeto1/tela/tela_login.dart';

void main() {
  runApp(MaterialApp(
    home: TelaListagem(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estoque Vegetal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: TelaListagem(),
    );
  }
}
