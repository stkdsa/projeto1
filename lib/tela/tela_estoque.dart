import 'package:flutter/material.dart';

import '../model_vegetal.dart';
import '../model_vegetal_estoque.dart';

class TelaEntrada extends StatefulWidget {
  @override
  TelaEntradaState createState() => TelaEntradaState();
}

class TelaEntradaState extends State<TelaEntrada> {
  Estoque estoque = Estoque();

  TextEditingController origemController = TextEditingController();
  TextEditingController litrosController = TextEditingController();
  TextEditingController responsavelController = TextEditingController();
  TextEditingController cidadeOrigemController = TextEditingController();
  TextEditingController dataColheitaController = TextEditingController();
  TextEditingController materialTonelController = TextEditingController();

  String dropdownValue = 'Pasteurizada';

  @override
  Widget build(BuildContext context) {
    Vegetal entrada = Vegetal('', 0.0);

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Pasteurizada', 'Coco', 'Tonel']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          TextField(
            controller: origemController,
            decoration: InputDecoration(labelText: 'Origem'),
          ),
          TextField(
            controller: litrosController,
            decoration: InputDecoration(labelText: 'Litros'),
            keyboardType: TextInputType.number,
          ),
          if (dropdownValue == 'Pasteurizada')
            TextField(
              controller: responsavelController,
              decoration: InputDecoration(labelText: 'Responsável pela Pasteurização'),
            ),
          if (dropdownValue == 'Coco')
            TextField(
              controller: cidadeOrigemController,
              decoration: InputDecoration(labelText: 'Cidade de Origem'),
            ),
          if (dropdownValue == 'Coco')
            TextField(
              controller: dataColheitaController,
              decoration: InputDecoration(labelText: 'Data de Colheita'),
            ),
          if (dropdownValue == 'Tonel')
            TextField(
              controller: materialTonelController,
              decoration: InputDecoration(labelText: 'Material do Tonel'),
            ),
          ElevatedButton(
            onPressed: () {
              String origem = origemController.text;
              double litros = double.tryParse(litrosController.text) ?? 0.0;

              if (dropdownValue == 'Pasteurizada') {
                String responsavel = responsavelController.text;
                DateTime dataPasteurizacao = DateTime.now();

              //   entrada = AguaPasteurizada(origem, litros, responsavel, dataPasteurizacao);
              // } else if (dropdownValue == 'Coco') {
              //   String cidadeOrigem = cidadeOrigemController.text;
              //   DateTime dataColheita = DateTime.now();
              //
              //   entrada = AguaNoCoco(origem, litros, cidadeOrigem, dataColheita);
              // } else if (dropdownValue == 'Tonel') {
              //   String materialTonel = materialTonelController.text;
              //
              //   entrada = AguaEmTonel(origem, litros, materialTonel);
              // }

              estoque.adicionarEntrada(entrada);

              origemController.clear();
              litrosController.clear();
              responsavelController.clear();
              cidadeOrigemController.clear();
              dataColheitaController.clear();
              materialTonelController.clear();

              setState(() {});

            child: Text('Adicionar Entrada'),
          ),
          Text('Saldo por entrada: ${estoque.calcularSaldoPorEntrada()}'),
          Text('Total de Vegetal: ${estoque.calcularTotalVegetal()}'),
        ],
      ),
    );
  }
}
