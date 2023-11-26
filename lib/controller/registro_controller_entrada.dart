import 'package:flutter/material.dart';
import 'package:flutter_projeto1/model/registro_entrada_model.dart';
import '../model/estoque_model.dart';

class RegistroControllerEntrada {
  void registrarMovimentacao(BuildContext context, RegistroEntrada movimentacaoEntrada) {
    Map<String, dynamic> dadosMovimentacao = {
      'Origem': movimentacaoEntrada.origem,
      'Mestre do Preparo': movimentacaoEntrada.mPreparo,
      'Mestre Auxiliar': movimentacaoEntrada.mAuxiliar,
      'Mestre Dirigente': movimentacaoEntrada.mDirigente,
      'Mestre Assistente': movimentacaoEntrada.mAssistente,
      'Litros': movimentacaoEntrada.litros,
    };

    double? litrosDouble = movimentacaoEntrada.litros != null
        ? double.tryParse(movimentacaoEntrada.litros!.toString().replaceAll(',', '.'))
        : null;

    Estoque estoque = Estoque();
    estoque.adicionarMovimentacaoEntrada(movimentacaoEntrada);
    double saldoTotal = estoque.calcularTotalVegetal();

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
              for (var entry in dadosMovimentacao.entries)
                Text('${entry.key}: ${entry.value}'),
              const SizedBox(height: 16),
              Text('Saldo Total no Estoque: $saldoTotal'),
            ],
          ),
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
