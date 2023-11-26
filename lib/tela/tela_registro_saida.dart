import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projeto1/controller/registro_controller.dart';
import 'package:flutter_projeto1/model/registro_saida_model.dart';
import 'package:flutter_projeto1/tela/tela_cadastrar_usuario.dart';
import 'package:flutter_projeto1/tela/tela_consulta.dart';
import 'package:flutter_projeto1/tela/tela_home.dart';
import 'package:flutter_projeto1/tela/tela_registro_bool.dart';
import '../componentes/bottom_nav_bar.dart';
//import '../controller/registro_saida_controller.dart';
import '../model/registro_global_model.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';



class TelaRegistroSaida extends StatefulWidget {
  final Function(RegistroModel) onRegistrarMovimentacao;

  const TelaRegistroSaida({Key? key, required this.onRegistrarMovimentacao}) : super(key: key);


  @override
  _TelaRegistroSaidaState createState() => _TelaRegistroSaidaState();
}

class _TelaRegistroSaidaState extends State<TelaRegistroSaida> {
  Destino? destino;
  String? mPreparo;
  String? mAuxiliar;
  String? mAssistente;
  String? mDirigente;
  double? litros;
  DateTime? dataRegistro;
  TextEditingController destinoController = TextEditingController();
  TextEditingController mPreparoController = TextEditingController();
  TextEditingController mAuxiliarController = TextEditingController();
  TextEditingController mAssistenteController = TextEditingController();
  TextEditingController mDirigenteController = TextEditingController();
  TextEditingController litrosController = TextEditingController();
  int _selectedIndex = 0;
  static const String naoAplicavel = 'N/A';
  RegistroController registroSaidaController = RegistroController();
  //FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('pt_BR', null);

    List<Destino> destinos = Destino.values;



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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<Destino>(
                value: destino,
                items: destinos.map((Destino value) {
                  return DropdownMenuItem<Destino>(
                    value: value,
                      child: Text(formatarNomeDestino(value)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    destino = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Destino',
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: destinoController,
                decoration: InputDecoration(
                  labelText: 'Mestre do Preparo',
                ),
                onChanged: (value) {
                  setState(() {
                    mPreparo = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: mAuxiliarController,
                decoration: InputDecoration(
                  labelText: 'Mestre Auxiliar',
                ),
                onChanged: (value) {
                  setState(() {
                    mAuxiliar = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: mAssistenteController,
                decoration: InputDecoration(
                  labelText: 'Mestre Assistente',
                ),
                onChanged: (value) {
                  setState(() {
                    mAssistente = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: mDirigenteController,
                decoration: InputDecoration(
                  labelText: 'Mestre Dirigente',
                ),
                onChanged: (value) {
                  setState(() {
                    mDirigente = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: litrosController,
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
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  registrarMovimentacao();
                  RegistroSaida movimentacao = RegistroSaida(
                    destino: destino,
                    mPreparo: mPreparo??'',
                    mAuxiliar: mAuxiliar??'',
                    mAssistente: mAssistente??'',
                    mDirigente: mDirigente??'',
                    litros: litros??0.0,
                    dataRegistro: dataRegistro??DateTime.now(),
                    isEntrada: false,
                  );
                  registroSaidaController.registrarMovimentacao(context, movimentacao);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  elevation: 20,
                  shadowColor: Colors.black54,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Registrar Saída'),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
        onSignOut: _signOut,
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TelaHome()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TelaRegistroBool()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TelaCadastrarUsuario()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  TelaConsulta()),
          );
          break;
        case 4:
          _signOut();
          break;
        default:

      }
    });
  }

  void _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, '/sair');
    } catch (e) {
      print('Erro ao fazer logout: $e');
    }
  }

  void registrarMovimentacao() {
    DateTime now = DateTime.now();
    dataRegistro = now;

    Destino? registroDestino = destino;
    String? registroMestrePreparo = mPreparo;
    String? registroMestreAuxiliar = mAuxiliar;
    String? registroMestreDirigente = mDirigente;
    String? registroMestreAssistente = mAssistente;
    double? registroLitros = litros;
    DateTime? registroData = dataRegistro;

    if (registroDestino != null &&
        registroMestrePreparo != null &&
        registroMestreAuxiliar != null &&
        registroLitros != null &&
        registroData != null) {
      RegistroSaida movimentacao = RegistroSaida(
        destino: registroDestino!,
        mPreparo: registroMestrePreparo!,
        mAuxiliar: registroMestreAuxiliar!,
        mDirigente: registroMestreDirigente ?? '',
        mAssistente: registroMestreAssistente ?? '',
        litros: registroLitros!,
        isEntrada: false,
        dataRegistro: registroData!,
      );

      salvarMovimentacaoNoFirestore(movimentacao);

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
                Text('Destino: ${formatarNomeDestino(registroDestino ?? Destino.borra)}'),
                Text('Mestre do Preparo: $registroMestrePreparo'),
                Text('Mestre Auxiliar: $registroMestreAuxiliar'),
                Text('Litros: $registroLitros'),
                Text('Saldo Total no Estoque: ${RegistroController.saldoTotal}'),
                Text('Data do Registro: ${registroData != null ? _formatarData(registroData) : naoAplicavel}'),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    destinoController.clear();
                    mPreparoController.clear();
                    mAuxiliarController.clear();
                    mAssistenteController.clear();
                    mDirigenteController.clear();
                    litrosController.clear();
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
  }

  void salvarMovimentacaoNoFirestore(RegistroSaida movimentacao) {
    String collectionName = 'movimentacaoSaida';

    switch (movimentacao.destino) {
      case Destino.borra:
        collectionName += '/borra';
        break;
      case Destino.doacao:
        collectionName += '/doacao';
        break;
      case Destino.emprestimo:
        collectionName += '/emprestimo';
        break;
      case Destino.fermentado:
        collectionName +='/fermentado';
        break;
      case Destino.preparo:
        collectionName += '/preparo';
        break;
      case Destino.recozimento:
        collectionName += '/recozimento';
        break;
      case Destino.sessao:
        collectionName += '/sessao';
      default:
        collectionName = 'movimentacaoSaidaPadrao';
        break;
    }
    FirebaseFirestore.instance
        .collection("movimentacaoSaida")
        .add({
      'destino': movimentacao.destino.toString(),
      'mPreparo': movimentacao.mPreparo,
      'mAuxiliar': movimentacao.mAuxiliar,
      'mDirigente': movimentacao.mDirigente,
      'mAssistente': movimentacao.mAssistente,
      'litros': movimentacao.litros,
          'dataRegistro': movimentacao.dataRegistro,
    })
        .then((value) {
      print("Movimentação salva no Firestore com ID: $value");
    })
        .catchError((error) {
      print("Erro ao salvar movimentação no Firestore: $error");
    });
  }


  String _formatarData(DateTime dateTime) {

    return DateFormat.yMd('pt_BR').format(dateTime);
  }
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
