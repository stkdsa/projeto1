import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  Color topColor = Color.fromARGB(255, 101, 128, 51);
  Color bottomColor = Color.fromARGB(255,193, 199, 146);
  Color fontColor = Color.fromARGB(255, 52, 53, 65);
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _opacityAnimation.addListener(() {
      setState(() {});
    });

    Future.delayed(Duration(seconds: 1), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/tela_login.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
                child: AnimatedBuilder(
                  animation: _opacityAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _opacityAnimation.value,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Hero(
                              tag: 'logoHero',
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: Image.asset(
                                  "assets/images/logo1.png",
                                  height: 200,
                                ),
                              ),
                            ),
                            SizedBox(height: 32),
                            TextFormField(
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: "E-mail",
                                prefixIcon: Icon(Icons.mail_outline_outlined),
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              validator: (String? value) {
                                if(value == null){
                                  return "O campo e-mail precisa ser preenchido";
                                }
                                if(!value.contains("@")){
                                  return "O e-mail não é válido";
                                }
                                return null;


                              },
                            ),
                            SizedBox(height: 19),
                            TextFormField(
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: "Senha",
                                prefixIcon: Icon(Icons.key_sharp,color: topColor,),
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(64),
                                  borderSide: const BorderSide(color: Colors.red),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                              obscureText: true,
                            ),
                            SizedBox(height: 32),
                            ElevatedButton(
                              onPressed: () {botaoPrincipalClicado();
                                },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.green,
                                onPrimary: Colors.white,
                                elevation: 20,
                                shadowColor: Colors.black54,
                                padding: EdgeInsets.symmetric(vertical: 15),
                              ),
                              child: Text(
                                "Entrar",
                                style: TextStyle(fontSize: 25),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  botaoPrincipalClicado(){
    if(_formKey.currentState!.validate()){
      print("validado");

    }
  }
}
