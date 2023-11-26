import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto1/tela/tela_base.dart'; // Importe a TelaBase

class TelaHome extends TelaBase { // Herde de TelaBase
  const TelaHome({Key? key}) : super(key: key);

  @override
  Widget corpoTela(BuildContext context) {

    // Personalize o corpo da tela aqui
    return Center(
      child: Text('Conteúdo da tela específica'),

    );
  }

}
