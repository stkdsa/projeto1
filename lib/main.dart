  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto1/componentes/roteador_de_tela.dart';
import 'package:flutter_projeto1/tela/tela_base.dart';
import 'package:flutter_projeto1/tela/tela_cadastrar_usuario.dart';
import 'package:flutter_projeto1/tela/tela_consulta.dart';
import 'package:flutter_projeto1/tela/tela_home.dart';
import 'package:flutter_projeto1/tela/tela_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_projeto1/tela/tela_registro_bool.dart';
import 'firebase_options.dart';

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  runApp( MaterialApp(
    home: RoteadorTela(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seu App',
      initialRoute: '/home',
      routes: {
        '/home': (context) => TelaHome(),
        '/cadastro': (context) => TelaCadastrarUsuario(),
        '/registro': (context) => TelaRegistroBool(),
         '/consulta': (context) => TelaConsulta(),
        '/sair': (context) => TelaLogin(),
      },
    );
  }
}
