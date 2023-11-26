import 'package:flutter/material.dart';

import '../model/registro_entrada_model.dart';
import '../model/registro_global_model.dart';

class TelaRegistroEntrada extends StatefulWidget {
  final Function(RegistroModel) onRegistrarMovimentacao;

  const TelaRegistroEntrada({Key? key, required this.onRegistrarMovimentacao}) : super(key: key);

  @override
  _TelaRegistroEntradaState createState() => _TelaRegistroEntradaState();
}

class _TelaRegistroEntradaState extends State<TelaRegistroEntrada> {
  Origem? origem;
  String? mestrePreparo;
  String? mestreAuxiliar;
  double? litros;
  DateTime? dataRegistro;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Color buttomColor = Color.fromARGB(255, 87, 150, 92);
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: const Color.fromARGB(255, 87, 150, 92),
        title: const Text("Registrar Saída"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () {
              Navigator.of(context).pop();}),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<Origem>(
              value: origem,
              items: Origem.values.map((Origem value) {
                return DropdownMenuItem<Origem>(
                  value: value,
                  child: Text(value.toString().split('.')[1]),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Origem',
              ),
              onChanged: (value) {
                setState(() {
                  origem = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Mestre do Preparo',
              ),
              onChanged: (value) {
                setState(() {
                  mestrePreparo = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Mestre Auxiliar',
              ),
              onChanged: (value) {
                setState(() {
                  mestreAuxiliar = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Litros',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  litros = double.tryParse(value);
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                registrarMovimentacaoEntrada();
              },
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all<Color>(buttomColor),
              ),
              child: const Text('Registrar Movimentação'),
            ),
          ],
        ),
      ),


    );

  }

  void registrarMovimentacaoEntrada() {
    DateTime now = DateTime.now();
    dataRegistro = now;

    if (origem != null) {
      if (mestrePreparo != null &&
          mestreAuxiliar != null &&
          litros != null &&
          dataRegistro != null) {
        RegistroEntrada movimentacao = RegistroEntrada(
          origem: origem!,
          mPreparo: mestrePreparo!,
          mAuxiliar: mestreAuxiliar!,
          mDirigente: "", // Adicione o valor apropriado se necessário
          mAssistente: "", // Adicione o valor apropriado se necessário
          litros: litros!,
          isEntrada: true,
          dataRegistro: dataRegistro!,
        );

        widget.onRegistrarMovimentacao(movimentacao);

        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Movimentação Registrada'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Dados da Movimentação:'),
                  const SizedBox(height: 8),
                  Text('Origem: ${movimentacao.origem.toString().split('.')[1]}'),
                  Text('Mestre do Preparo: ${movimentacao.mPreparo}'),
                  Text('Mestre Auxiliar: ${movimentacao.mAuxiliar}'),
                  Text('Litros: ${movimentacao.litros}'),
                  Text('Data do Registro: ${movimentacao.dataRegistro}'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    setState(() {
                      origem = null;
                      mestrePreparo = null;
                      mestreAuxiliar = null;
                      litros = null;
                      dataRegistro = null;
                    });
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Caso algum dos valores necessários seja nulo, exiba um alerta ou faça algo apropriado para lidar com a situação
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Erro'),
              content: const Text('Preencha todos os campos necessários.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Caso a origem seja nula, exiba um alerta ou faça algo apropriado para lidar com a situação
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Erro'),
            content: const Text('Por favor, selecione uma origem.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

}
