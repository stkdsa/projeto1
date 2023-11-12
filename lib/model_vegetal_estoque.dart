import 'model_vegetal.dart';

class Estoque {
  List<Vegetal> entradas = [];

  void adicionarEntrada(Vegetal entrada) {
    entradas.add(entrada);
  }

  Map<String, double> calcularSaldoPorEntrada() {
    Map<String, double> saldoPorEntrada = {};

    for (var entrada in entradas) {
      saldoPorEntrada[entrada.origem] = (saldoPorEntrada[entrada.origem] ?? 0) + entrada.litros;
    }

    return saldoPorEntrada;
  }

  double calcularTotalVegetal() {
    double totalVegetal = 0;

    for (var entrada in entradas) {
      totalVegetal += entrada.litros;
    }

    return totalVegetal;
  }
}
