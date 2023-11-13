import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  Color topColor = Color.fromARGB(255, 2, 159, 212);
  Color bottomColor = Color.fromARGB(255, 168, 227, 247);
  Color fontColor = Color.fromARGB(255, 52, 53, 65);
  bool conectado = false;
  final ButtonStyle style =
      ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [topColor, bottomColor])),
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: 15,
              ),
              child: Image.asset("assets/images/logo1.png"),
            ),
            SizedBox(
              height: 32,
            ),
            Form(
                child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "E-mail",
                    //labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.mail_outline_outlined,
                      //color: Colors.white,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                )
              ],
            )),
            SizedBox(
              height: 19,
            ),
            Form(
                child: Column(
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "Senha",
                    //labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.key_sharp,
                      //color: Colors.white,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      primary: topColor, onPrimary: Colors.white,elevation: 20,shadowColor: Colors.black54),
                  child: const Text(
                    "Entrar",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    )));
  }
}
