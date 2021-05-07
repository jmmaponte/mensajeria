// importamos la libreria
import 'package:firebase_auth/firebase_auth.dart';

// creamos la clase
class Authprovider {
  // la varible de instancia de tipo FirebaseAuth
  FirebaseAuth _firebaseAuth;
// declaramos constructor
  Authprovider() {
    // inciaimos la instacia la clase
    //
    _firebaseAuth = FirebaseAuth.instance;
  }
// vamos a traernos los datos actulaes  usuarios actual el sistemas paara capturarlo

  User getUser() {
    return _firebaseAuth.currentUser;
  }

  bool isSingIn() {
    final currenUser = _firebaseAuth.currentUser;
    if (currenUser == null) {
      return false;
    }
    return true;
  }

// vamos a crear el metodo para hacer login  a firebase
// al cual le pasamos dos parametros
// el metodo future reeempplazs ma so menos por decirlo a la promesa de javascriopt
// y promete devolver algun valor u ojeto que peude se de tipo json entre otros

// con asynn le inicamos que le metodo es asyncron,,, hacemos la peticion  la google o nube
  Future<bool> logon(String email, String password) async {
    String errorMsg;
    try {
      // le -pasamos la varibale de clase y llamanos le metodo de autecnicacion de google  y le pasamos los parametros
      // await espera que el proceso o la peticion termine de ejecutarse
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      // esto regresa el codigo de erros si no fallo el en login
      // no hya conexion
      // ex ddio tiempo de espera
      print(error);

      errorMsg = error.code;
    }
    if (errorMsg != null) {
      //si hay error
      return Future.error(errorMsg);
    }
    return true;
  }

//  el el mismo codigo le pasamos los argumentos
  Future<bool> registro(String email, String password) async {
    String errorMsg;
    try {
      // le -pasamos la varibale de clase y llamanos le metodo de autecnicacion de google  y le pasamos los parametros
      // await espera que el proceso o la peticion termine de ejecutarse
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (error) {
      // esto regresa el codigo de erros si no fallo el en login
      // no hya conexion
      // ex ddio tiempo de espera
    //  print(error);

      errorMsg = error.code;
    }
    if (errorMsg != null) {
      //si hay error
      return Future.error(errorMsg);
    }
    return true;
  }

  // metodo para cerra session
  //
  Future<void> singOut() async {
    return Future.wait([_firebaseAuth.signOut()]);
  }
}
