import 'package:firebase_auth/firebase_auth.dart';

class AutenticacaoServico {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  cadastrarUsuario({required String nome,
    required String email,
    required String senha,
    required String confirmaSenha}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
          email: email,
          password: senha);
      await userCredential.user!.updateDisplayName(nome);
      return null;
    }
    on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "Usuário já cadastrado";
      }
      return "Desculpe, erro desconhecido";
    }
  }

  Future<String?> logarUsuario({
    required String email,
    required String senha})async{
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return null;
    } on FirebaseAuthException catch(e){
      return e.message;
    }


  }
Future <void> deslogar() async{
    return _firebaseAuth.signOut();
}

}
