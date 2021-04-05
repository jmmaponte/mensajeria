import 'package:flutter/material.dart';
import 'package:formulario/src/provedores/authenProv.dart';

class ControlLogin {
  BuildContext context;

// varibale para  allacemdar datos del login y procesarla
  TextEditingController correocontroler = new TextEditingController();
  TextEditingController passdcontroler = new TextEditingController();

// creamos una propiedad de tipo Autheproveedor//
  Authprovider _authProvider;

// constrcutor
  Future init (BuildContext context) {
    this.context = context;
    // la variable imstaciomos la clase
    _authProvider = new Authprovider();
  }

// meetodo de registro
  void iraRegistro() {
    Navigator.pushNamed(context, '/registro');
  }
// metodo se usara cuando el user preiones el boton.. hace la asginacion a los
  // campos y hace la peticiocon el servidor
  void logon() async {
    String email = correocontroler.text?.trim();
    String password = passdcontroler.text?.trim();
    print('$email');
    print('$password');

    try {
      // declaramos una varibale boolena para que nos guarde lo que retorne la consulta
      bool elogin = await _authProvider.logon(email, password);

      if (elogin) {
        print('el usuario esta logueado');
      } else {
        print('muy pailas');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
