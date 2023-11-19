
import 'model_movimentacao_vegetal.dart';

class Estoque {
  List<MovimentacaoVegetal> movimentacoes = [];

  void adicionarMovimentacao(MovimentacaoVegetal movimentacao) {
    movimentacoes.add(movimentacao);
  }

  Map<String, double> calcularSaldoPorOrigem() {
    Map<String, double> saldoPorOrigem = {};

    for (var movimentacao in movimentacoes) {
      if (movimentacao.isEntrada) {
        saldoPorOrigem[movimentacao.origem] =
            (saldoPorOrigem[movimentacao.origem] ?? 0) + (movimentacao.litros ?? 0).toDouble();
      } else {
        saldoPorOrigem[movimentacao.origem] =
            (saldoPorOrigem[movimentacao.origem] ?? 0) - (movimentacao.litros ?? 0).toDouble();
      }
    }

    return saldoPorOrigem;
  }


  double calcularTotalVegetal() {
    double saldoTotal = 0;

    for (var movimentacao in movimentacoes) {
      saldoTotal += movimentacao.isEntrada ? (movimentacao.litros ?? 0) : -(movimentacao.litros ?? 0);
    }

    return saldoTotal;
  }
}
