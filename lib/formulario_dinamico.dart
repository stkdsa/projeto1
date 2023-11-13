import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormularioDinamico extends StatefulWidget {
  final String tipoSelecionado;

  const FormularioDinamico({Key? key, required this.tipoSelecionado}) : super(key: key);

  @override
  _FormularioDinamicoState createState() => _FormularioDinamicoState();
}

class _FormularioDinamicoState extends State<FormularioDinamico> {
  TextEditingController campo1Controller = TextEditingController();
  TextEditingController campo2Controller = TextEditingController();
  TextEditingController campoPreparoController = TextEditingController();
  TextEditingController campoSessaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro - ${widget.tipoSelecionado}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ///falta eh coisa...kkkk
          ],
        ),
      ),
    );
  }
}