import 'package:flutter_projeto1/model/registro_entrada_model.dart';
import 'package:flutter_projeto1/model/registro_saida_model.dart';

class Estoque {
  List<RegistroEntrada> movimentacoesEntrada = [];
  List<RegistroSaida> movimentacoesSaida = [];

  void adicionarMovimentacaoEntrada(RegistroEntrada movimentacaoEntrada) {
    movimentacoesEntrada.add(movimentacaoEntrada);
  }

  void adicionarMovimentacaoSaida(RegistroSaida movimentacaoSaida) {
    movimentacoesSaida.add(movimentacaoSaida);
  }

  Map<String, double> calcularSaldoPorOrigem() {
    Map<String, double> saldoPorOrigem = {};

    for (var movimentacao in movimentacoesEntrada) {
      String origemString = movimentacao.origem.toString().split('.').last;
      saldoPorOrigem[origemString] = (saldoPorOrigem[origemString] ?? 0) + movimentacao.litros!;
    }

    for (var movimentacao in movimentacoesSaida) {
      String destinoString = movimentacao.destino.toString().split('.').last;
      saldoPorOrigem[destinoString] = (saldoPorOrigem[destinoString] ?? 0) - movimentacao.litros!;
    }

    return saldoPorOrigem;
  }

  double calcularTotalVegetal() {
    double saldoTotal = 0;

    for (var movimentacao in movimentacoesEntrada) {
      saldoTotal += movimentacao.litros!;
    }

    for (var movimentacao in movimentacoesSaida) {
      saldoTotal -= movimentacao.litros!;
    }

    return saldoTotal;
  }
}
