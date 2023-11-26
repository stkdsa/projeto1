import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto1/formulario_dinamico.dart';
import 'package:flutter_projeto1/tela/tela_cadastrar_usuario.dart';
import 'package:flutter_projeto1/tela/tela_home.dart';
import 'package:flutter_projeto1/tela/tela_lista_entradas.dart';
import 'package:flutter_projeto1/servicos/autenticacao_servico.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({Key? key}) : super(key: key);

  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin>
  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  Color topColor = const Color.fromARGB(255, 101, 128, 51);
  Color bottomColor = const Color.fromARGB(255, 193, 199, 146);
  Color buttonColor = const Color.fromARGB(255, 87, 150, 92);
  Color fontColor = const Color.fromARGB(255, 52, 53, 65);
  final _formKey = GlobalKey<FormState>();
  bool obscureText = true;

  final AutenticacaoServico _autServ = AutenticacaoServico();
  final TextEditingController _emailLoginController = TextEditingController();
  final TextEditingController _senhaLoginController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _opacityAnimation.addListener(() {
      setState(() {});
    });

    Future.delayed(const Duration(seconds: 3), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/tela1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 100),
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
                            const SizedBox(height: 32),
                            Expanded(
                              child: TextFormField(
                                controller: _emailLoginController,
                                autofocus: true,
                                decoration: const InputDecoration(
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
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                ),
                                validator: (String? value) {
                                  if (value == null) {
                                    return "O campo e-mail precisa ser preenchido";
                                  }
                                  if (!value.contains("@")) {
                                    return "O e-mail não é válido";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(height: 19),
                            TextFormField(
                              controller: _senhaLoginController,
                              autofocus: true,
                              decoration: InputDecoration(
                                hintText: "Senha",
                                prefixIcon: Icon(
                                  Icons.key_sharp,
                                  color: topColor,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: topColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obscureText = !obscureText;
                                    });
                                  },
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(64),
                                  borderSide:
                                  const BorderSide(color: Colors.red),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 10),
                              ),
                              obscureText: obscureText,
                            ),

                            //SizedBox(height: 8),
                            TextButton(
                              onPressed: () {
                                print("email senha");
                                esqueceuASenhaClicado();
                              },
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Esqueceu a senha?",
                                  style: TextStyle(
                                    color: Colors.white,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: EntrarClicado,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: buttonColor,
                                elevation: 18,
                                shadowColor: Colors.black54,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                              ),
                              child: const Text(
                                "Entrar",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(height: 54),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo_flutter.png',
                        height: 15,
                        width: 15,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        "Este aplicativo foi desenvolvido utilizando Flutter",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
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

  EntrarClicado() async {
    if (_formKey.currentState!.validate()) {
      String? resultado = await _autServ.logarUsuario(
        email: _emailLoginController.text,
        senha: _senhaLoginController.text,
      );

      if (resultado == null) {
        print("Login bem-sucedido");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TelaHome()),
        );
      } else {
        String mensagemErro = _getMensagemErro(resultado);
        mostrarSnackBar(mensagemErro, isErro: true);
        print("Erro no login: $resultado");
      }
    }
  }

  String _getMensagemErro(String codigoErro) {
    switch (codigoErro) {
      case "user-not-found":
        return "E-mail não cadastrado. Verifique o e-mail informado.";
      case "wrong-password":
        return "Senha incorreta. Verifique a senha informada.";
      default:
        return "Erro ao fazer login. Verifique os campos de email e senha.";
    }
  }


  Future<void> esqueceuASenhaClicado() async {
    String email = _emailLoginController.text;
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController redefinirSenhaController = TextEditingController(text: email);
        return AlertDialog(
          title: const Text(
            "E-mail para redefinir senha:",
            style: TextStyle(color: Colors.black54),
          ),
          content: TextFormField(
            controller: redefinirSenhaController,
            decoration: const InputDecoration(label: Text("Confirme o e-mail")),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(33)),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                String? erro = await _autServ.redefinicaoSenha(email: email);

                if (erro == null) {
                  mostrarSnackBar("E-mail de redefinição enviado com sucesso!");
                } else {
                  mostrarSnackBar("Erro: $erro", isErro: true);
                }

                Navigator.pop(context); // Fechar o AlertDialog
              },
              child: const Text(
                "Redefinir Senha", style: TextStyle(color: Colors.black54),
              ),
            ),
          ],
        );
      },
    );
  }

  void mostrarSnackBar(String mensagem, {bool isErro = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensagem,
          style: TextStyle(color: Colors.black54),
        ),
        duration: Duration(seconds: 5),
        backgroundColor: isErro
            ? Colors.deepOrange
            : Colors.white,
      ),
    );
  }
}