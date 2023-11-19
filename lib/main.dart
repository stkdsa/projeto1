import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto1/tela/tela_base.dart';
import 'package:flutter_projeto1/tela/tela_cadastrar_usuario.dart';
import 'package:flutter_projeto1/tela/tela_consulta.dart';
import 'package:flutter_projeto1/tela/tela_home.dart';
import 'package:flutter_projeto1/tela/tela_lista_entradas.dart';
import 'package:flutter_projeto1/tela/tela_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_projeto1/tela/tela_registro.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "projetoDemec",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MaterialApp(
    home: TelaBase(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seu App',
      initialRoute: '/home', // Defina a rota inicial, por exemplo, '/home'
      routes: {
        '/home': (context) => TelaListagem(),
        '/cadastro': (context) => TelaCadastrarUsuario(),
        //'/registro': (context) => TelaRegistro(),
       // '/consulta': (context) => TelaConsulta(),
        '/sair': (context) => TelaLogin(), // Adicione a rota para a tela de login
      },
    );
  }
}
class RoteadorTela extends StatefulWidget {
  const RoteadorTela({super.key});

  @override
  State<RoteadorTela> createState() => _RoteadorTelaState();
}

class _RoteadorTelaState extends State<RoteadorTela> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context,snapshot){
        if (snapshot.hasData){
          return const TelaListagem(); ///depois trocar pela home que ainda nao esta feita
        }
        else{
          return const TelaLogin();
        }
      });
  }
}

