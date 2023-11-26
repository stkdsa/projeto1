import 'package:flutter_projeto1/model/registro_global_model.dart';

class RegistroEntrada extends RegistroModel {
  final Origem origem;

  RegistroEntrada({
    required this.origem,
    required String mPreparo,
    required String mAuxiliar,
    required String mDirigente,
    required String mAssistente,
    required double litros,
    required bool isEntrada,
    required DateTime dataRegistro,
  }) : super(
    mPreparo: mPreparo,
    mAuxiliar: mAuxiliar,
    mDirigente: mDirigente,
    mAssistente: mAssistente,
    litros: litros,
    tipoMovimentacao: isEntrada ? TipoMovimentacao.entrada : TipoMovimentacao.saida,
    dataRegistro: dataRegistro,
  );
}
