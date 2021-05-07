import 'package:flutter/material.dart';
import 'package:formulario/src/Utilidades/progesoDialogo.dart';
import 'package:formulario/src/Utilidades/sharePreferences.dart';
import 'package:formulario/src/modelos/Customer.dart';
import 'package:formulario/src/modelos/Messenger.dart';
import 'package:formulario/src/provedores/CustomerProvider.dart';
import 'package:formulario/src/provedores/MenssengerProvider.dart';
import 'package:formulario/src/provedores/authenProv.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:formulario/src/Utilidades/barraMensajes.dart' as util;

class ControlLogin {
  BuildContext context;
  // global key
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
// varibale para  allacemdar datos del login y procesarla
  TextEditingController correocontroler = new TextEditingController();
  TextEditingController passdcontroler = new TextEditingController();
// importamamos las clases y la refereciamos a una variable
// creamos una propiedad de tipo Autheproveedor//
  Authprovider _authProvider;
  ProgressDialog _progressDialog;
  SharePreferences _preferences;
  //isntanciamos los dos provvedores
  CustomerProvider _customerProvider;
  MessengerProvider _messengerProvider;

  String _typeUser;
  
// constrcutor
  Future init(BuildContext context) async {
    this.context = context;
    // la variable imstaciomos las clases
    _authProvider = new Authprovider();
   _customerProvider = CustomerProvider();
     _messengerProvider = MessengerProvider();
         // instalaciomos a la varibale la clase que creamos el la utlidad progreso
// dialogo
   _progressDialog =
        MyDialogoProgreso.createProgressDailog(context, "espere por favor");
    _preferences = new SharePreferences();
    // los incializamos
    // leemos el tipo de usuario o perfil que acamos de elegir
    //   ('============== TIPO DE USUARIO===============');
    _typeUser = await _preferences.read('typeUser');
  }

// meetodo de registro
//
//
  void iraRegistro() {
    if (_typeUser == 'cliente') {
      Navigator.pushNamed(context, 'cliente/registro');
    } else {
      Navigator.pushNamed(context, 'mensajero/registro');
    }
  }

// metodo se usara cuando el user preiones el boton.. hace la asginacion a los
  // campos y hace la peticiocon el servidor
  void logon() async {
    String email = correocontroler.text?.trim();
    String password = passdcontroler.text?.trim();
    print('$email');
    print('$password');

    _progressDialog.show();

    try {
      // declaramos una varibale boolena para que nos guarde lo que retorne la consulta
      bool elogin = await _authProvider.logon(email, password);
      _progressDialog.hide();
      if (elogin) {
        if (_typeUser == 'cliente') {
          Customer customer =  await _customerProvider.getById(_authProvider.getUser().uid);

          if (customer != null) {
            util.BarraMsg.showSnackbar(context, key, "login exitoso");
            Navigator.pushNamedAndRemoveUntil(
                context, 'cliente/mapa', (route) => false);
          } else {
            util.BarraMsg.showSnackbar(
                context, key, "no pudo ser logueado o usuario no existe");
            // si el usuario ingresa los datos de manera incorrecta
            // debemos cerra esa session-metodo
            await _authProvider.singOut();
          }
        }
//// validamos cuando el tipo de usuaurio sea mensajero
        else if (_typeUser == 'mensajero') {
          Messenger mensajero =
              await _messengerProvider.getById(_authProvider.getUser().uid);

          if (mensajero != null) {
            util.BarraMsg.showSnackbar(context, key, "login exitoso");
            Navigator.pushNamedAndRemoveUntil(
                context, 'mensajero/mapa', (route) => false);
          } else {
            util.BarraMsg.showSnackbar(
                context, key, "no pudo ser logueado o usuario no existe");
            // si el usuario ingresa los datos de manera incorrecta
            // debemos cerra esa session-metodo
            await _authProvider.singOut();
          }
        }
      }
      else {
        util.BarraMsg.showSnackbar(context, key, 'El usuario no se pudo autenticar');
        print('El usuario no se pudo autenticar');
      }

    } catch (error) {
      _progressDialog.hide();
      util.BarraMsg.showSnackbar(context, key, 'Error: $error');
    }
  }
}
