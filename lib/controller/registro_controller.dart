import 'package:flutter/material.dart';
import '../model/estoque_model.dart';
import '../model/registro_entrada_model.dart';
import '../model/registro_global_model.dart';
import '../model/registro_saida_model.dart';

class RegistroController {
  static double saldoTotal = 0.0;
  double? litrosDouble =0.0;

  void registrarMovimentacao(
      BuildContext context,
      RegistroModel movimentacao,
      ) {
    Map<String, dynamic> dadosMovimentacao = {
      'Origem/Destino': movimentacao is RegistroEntrada
          ? movimentacao.origem.toString()
          : (movimentacao as RegistroSaida).destino?.toString() ?? 'N/A',
      'Mestre do Preparo': movimentacao.mPreparo,
      'Mestre Auxiliar': movimentacao.mAuxiliar,
      'Mestre Dirigente': movimentacao.mDirigente,
      'Mestre Assistente': movimentacao.mAssistente,
      'Litros': movimentacao.litros,
    };

    litrosDouble = movimentacao.litros != null
        ? double.tryParse(movimentacao.litros!.toString().replaceAll(',', '.'))
        : null;

    Estoque estoque = Estoque();

    if (movimentacao is RegistroEntrada) {
      estoque.adicionarMovimentacaoEntrada(movimentacao);
    } else if (movimentacao is RegistroSaida) {
      estoque.adicionarMovimentacaoSaida(movimentacao);
    }

    saldoTotal = estoque.calcularTotalVegetal();

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
              const SizedBox(height: 16),
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
