import 'package:flutter/material.dart';

class TelaCadastrarUsuario extends StatefulWidget {
  const TelaCadastrarUsuario({Key? key}) : super(key: key);

  @override
  _TelaCadastrarUsuarioState createState() => _TelaCadastrarUsuarioState();
}

class _TelaCadastrarUsuarioState extends State<TelaCadastrarUsuario>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  Color topColor = Color.fromARGB(255, 101, 128, 51);
  final _formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;



  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _senhaController = TextEditingController();
  TextEditingController _senhaConfirmacaoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

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
      appBar: AppBar(
        backgroundColor: topColor,
        title: Text("Cadastro de Usuários"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
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
                        SizedBox(height: 32),
                        TextFormField(
                          controller: _nomeController,
                          autofocus: true,
                          decoration: InputDecoration(
                            hintText: "Nome e sobrenome do novo usuário",
                            prefixIcon: Icon(Icons.person),
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
                            if (value == null || value.isEmpty) {
                              return "O campo deverá ser preenchido com nome e sobrenome do usuário";
                            }
                            List<String> partesNome = value.split(' ');

                            if (partesNome.length < 2) {
                              return "Por favor, informe o nome e o sobrenome";
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 19),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "E-mail do novo usuário",
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
                            if (value == null || value.isEmpty) {
                              return "O campo e-mail precisa ser preenchido";
                            }
                            if (!value.contains("@") || !value.contains(".")) {
                              return "O e-mail não é válido. Certifique-se de incluir '@' e '.'";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 19),
                        TextFormField(

                          decoration: InputDecoration(
                            hintText: "Digite a senha",
                            prefixIcon: Icon(Icons.key_sharp, color: topColor),
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
                          controller: _senhaController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "O campo senha precisa ser preenchido";
                            }
                            String? senhaErro = senhaValidator(value);
                            if (senhaErro != null) {
                              return senhaErro;
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        SizedBox(height: 19),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: "Confirme a senha",
                            prefixIcon: Icon(Icons.check, color: topColor),
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
                          controller: _senhaConfirmacaoController,
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "O campo de confirmação de senha precisa ser preenchido";
                            }

                            // Verifica se a senha de confirmação é igual à senha original
                            if (value != _senhaController.text) {
                              return "As senhas não coincidem";
                            }

                            return null;
                          },
                          obscureText: true,
                        ),
                        SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: botaoPrincipalClicado,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            onPrimary: Colors.white,
                            elevation: 20,
                            shadowColor: Colors.black54,
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: Text(
                            "Cadastrar Novo Usuário",
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                        SizedBox(height: 60),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void botaoPrincipalClicado() {
    if (_formKey.currentState!.validate()) {
      ///tem eh chão
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Cadastro realizado com sucesso!"),
        ),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String? senhaValidator(String? value) {
    List<String> mensagensValidacao = [];

    if (value == null || !value.contains(RegExp(r'[A-Z]'))) {
      mensagensValidacao.add("A senha deve conter pelo menos uma letra maiúscula");
    }

    if (value == null || !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      mensagensValidacao.add("A senha deve conter pelo menos um caractere especial");
    }

    if (value == null || !value.contains(RegExp(r'[0-9]'))) {
      mensagensValidacao.add("A senha deve conter pelo menos um número");
    }

    if (value != null && value.length != 6) {
      mensagensValidacao.add("A senha deve ter exatamente 6 caracteres");
    }

    return mensagensValidacao.isNotEmpty ? mensagensValidacao.join("\n") : null;
  }
}
