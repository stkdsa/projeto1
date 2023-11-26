enum Origem {
  borra,
  doacao,
  emprestimo,
  fermentado,
  preparo,
  recozimento,
  sessao,
}

enum Destino {
  borra,
  doacao,
  emprestimo,
  fermentado,
  preparo,
  recozimento,
  sessao,
}

enum TipoMovimentacao {
  entrada,
  saida,
}

class RegistroModel {
  final String? mPreparo, mAuxiliar, mAssistente, mDirigente;
  final double? litros;
  final DateTime dataRegistro;
  final TipoMovimentacao tipoMovimentacao;


  RegistroModel({
    required this.mPreparo,
    required this.mAuxiliar,
    required this.mDirigente,
    required this.mAssistente,
    required this.litros,
    required this.tipoMovimentacao,
    required this.dataRegistro,
  });

  String formatarNomeDestino(Destino destino) {
    switch (destino) {
      case Destino.borra:
        return 'Borra';
      case Destino.doacao:
        return 'Doação';
      case Destino.emprestimo:
        return 'Empréstimo';
      case Destino.fermentado:
        return 'Fermentado';
      case Destino.preparo:
        return 'Preparo';
      case Destino.recozimento:
        return 'Recozimento';
      case Destino.sessao:
        return 'Sessão';

      default:
        return destino.toString();
    }
  }
}
