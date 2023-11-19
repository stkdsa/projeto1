class MovimentacaoVegetal {
  String origem;
  String? mPreparo, mAuxiliar, mAssistente,mDirigente;
  double? litros;
  bool isEntrada;

  MovimentacaoVegetal({
    required this.origem,
    required this.mPreparo,
    required this.mAuxiliar,
    required this.mDirigente,
    required this.mAssistente,
    required this.litros,
    required this.isEntrada,
  }): assert(origem.isNotEmpty,);
}