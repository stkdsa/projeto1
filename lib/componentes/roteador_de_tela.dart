import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../tela/tela_home.dart';
import '../tela/tela_login.dart';

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
            return const TelaHome();
          }
          else{
            return const TelaLogin();
          }
        });
  }
}
