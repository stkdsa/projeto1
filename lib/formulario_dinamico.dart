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
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [

            /// Adicione aqui os widgets que você deseja exibir no corpo da tela
            // Exemplo:
            TextField(
              controller: campo1Controller,
              decoration: InputDecoration(labelText: 'Campo 1'),
            ),
            TextField(
              controller: campo2Controller,
              decoration: InputDecoration(labelText: 'Campo 2'),
            ),
            // ... outros widgets
          ],
        ),
      ),
    );
  }
}