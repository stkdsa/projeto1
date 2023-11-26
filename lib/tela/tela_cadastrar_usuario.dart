import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto1/servicos/autenticacao_servico.dart';
import 'package:flutter_projeto1/tela/tela_consulta.dart';
import 'package:flutter_projeto1/tela/tela_home.dart';
import 'package:flutter_projeto1/tela/tela_registro_bool.dart';
import 'package:flutter_projeto1/tela/tela_registro_entrada.dart';
import '../componentes/bottom_nav_bar.dart';


class TelaCadastrarUsuario extends StatefulWidget {
  const TelaCadastrarUsuario({Key? key}) : super(key: key);

  get emailController => null;

  get senhaController => null;

  @override
  _TelaCadastrarUsuarioState createState() => _TelaCadastrarUsuarioState();

}

class _TelaCadastrarUsuarioState extends State<TelaCadastrarUsuario>
  with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  bool obscureText = true;
  bool mostrarSenhaConfirmacao = false;


  Color topColor = const Color.fromARGB(255, 101, 128, 51);
  Color buttomColor = Color.fromARGB(255, 87, 150, 92);
  late Color iconColor = Colors.grey;
  final _formKey = GlobalKey<FormState>();
  int _selectedIndex = 0;
  final AutenticacaoServico _autServ = AutenticacaoServico();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _senhaConfirmacaoController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _opacityAnimation.addListener(() {
      setState(() {});
    });

    Future.delayed(const Duration(seconds: 1), () {
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 87, 150, 92),
        title: const Text("Cadastro de Usuários"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: () {
                Navigator.of(context).pop();}),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: SizedBox(
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
                        const SizedBox(height: 32),
                        Expanded(
                          child: TextFormField(
                            controller: _nomeController,
                            autofocus: true,
                            decoration:  InputDecoration(
                              hintText: "Nome e sobrenome do novo usuário",
                              prefixIcon: Icon(Icons.person, color: iconColor),
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: const Color.fromARGB(255, 87, 150, 92),),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: iconColor),

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
                        ),
                        const SizedBox(height: 19),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: "E-mail do novo usuário",
                            prefixIcon: Icon(Icons.mail_outline_outlined, color: iconColor),
                            fillColor: Colors.white,
                            filled: true,
                            border: OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 87, 150, 92),),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
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
                        const SizedBox(height: 19),
                        TextFormField(

                          decoration: InputDecoration(
                            labelText: "Senha",
                            hintText: "Digite a senha",
                            prefixIcon: Icon(Icons.key_sharp, color: iconColor),
                            fillColor: Colors.white,
                            filled: true,
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: const Color.fromARGB(255, 87, 150, 92),),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(64),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                          ),
                          controller: _senhaController,
                          onTap: () {
                            String mensagem = "Condições para a senha:\n\n- Deve conter pelo menos uma letra maiúscula\n- Deve conter pelo menos um caractere especial\n- Deve conter pelo menos um número\n- Deve ter exatamente 6 caracteres";
                            exibirMensagemValidacao(mensagem);
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "O campo senha precisa ser preenchido";
                            }
                            String? senhaErro = validadorSenha(value);
                            if (senhaErro != null) {
                              return senhaErro;
                            }
                            return null;
                          },
                          obscureText: true,
                        ),
                        const SizedBox(height: 19),
                TextFormField(

                controller: _senhaConfirmacaoController,
                obscureText: !mostrarSenhaConfirmacao,
                decoration: InputDecoration(
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: const Color.fromARGB(255, 87, 150, 92),),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(64),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                hintText: "Confirme a senha",
                prefixIcon: Icon(Icons.check, color: iconColor),
                suffixIcon: IconButton(
                icon: Icon(
                mostrarSenhaConfirmacao ? Icons.visibility : Icons.visibility_off,
                color: iconColor,
                ),

                onPressed: () {
                setState(() {
                mostrarSenhaConfirmacao = !mostrarSenhaConfirmacao;
                });
                },
                ),
                ),

                ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          onPressed: CadastrarClicado,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.green,
                            elevation: 20,
                            shadowColor: Colors.black54,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: const Text(
                            "Cadastrar Novo Usuário",
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onSignOut: _signOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void CadastrarClicado() {
    String nome = _nomeController.text;
    String email = _emailController.text;
    String senha = _senhaController.text;
    String confirmaSenha = _senhaConfirmacaoController.text;

    if (_formKey.currentState!.validate()) {
      print("Entrada validada");
      _autServ.logarUsuario(email: email, senha: senha).then((String? erro) => null);
      print("$_nomeController,$_emailController,$_senhaController,$_senhaConfirmacaoController,");
      _autServ.cadastrarUsuario(nome: nome, email: email, senha: senha, confirmaSenha: confirmaSenha);

      _nomeController.clear();
      _emailController.clear();
      _senhaController.clear();
      _senhaConfirmacaoController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cadastro realizado com sucesso!"),
        ),
      );
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TelaHome()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TelaRegistroBool()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TelaCadastrarUsuario()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  TelaConsulta()),
          );
          break;
        case 4:
          _signOut();
          break;
        default:

      }
    });
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/sair');
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }

  void exibirMensagemValidacao(String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Condições de Validação"),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  String? validadorSenha(String? value) {
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
