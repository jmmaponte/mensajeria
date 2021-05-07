import 'package:flutter/material.dart';
import 'package:formulario/src/Utilidades/progesoDialogo.dart';
import 'package:formulario/src/modelos/Messenger.dart';
import 'package:formulario/src/provedores/MenssengerProvider.dart';
import 'package:formulario/src/provedores/authenProv.dart';
// importamos
import 'package:formulario/src/Utilidades/barraMensajes.dart' as util;
import 'package:progress_dialog/progress_dialog.dart';

class MesanjeroControlRegistro {
  BuildContext context;

  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

// varibale para  almacenar datos del login y procesarla
   TextEditingController placacontroler = new TextEditingController();
  TextEditingController  namecontroler = new TextEditingController();
  TextEditingController  mobilcontroler = new TextEditingController();
  TextEditingController  correocontroler = new TextEditingController();
  TextEditingController  passdcontroler = new TextEditingController();
  TextEditingController  repeatpassdcontroler = new TextEditingController();

// importamos una propiedad de tipo Autheproveedor//
  Authprovider _authProvider;
  MessengerProvider  _messengerProvider;
   ProgressDialog _progressDialog;

  Future init (BuildContext context) {
    this.context = context;
    // la variable imstaciomos la clase y la incializacmos
    //
    _authProvider = new Authprovider();
    // incializamos
    _messengerProvider = new MessengerProvider();
      
       _progressDialog = MyDialogoProgreso.createProgressDailog(context, "espere por favor");
  }

// metodo se usara cuando el user preiones el boton.. hace la asginacion a los
  // campos y hace la peticiocon el servidor
  void registro() async {
    String placa =  placacontroler.text?.trim();
    String name = namecontroler.text?.trim();
    String mobil = mobilcontroler.text?.trim();
    String email = correocontroler.text?.trim();
    String passd = passdcontroler.text?.trim();
    String repeatpassd = repeatpassdcontroler.text?.trim();

 print('$placa');
   print('$name');
   print('$mobil');
   print('$email');
   print('$passd');
    print('$repeatpassd');

    if (placa.isEmpty && email.isEmpty && passd.isEmpty && repeatpassd.isEmpty) {
      util.BarraMsg.showSnackbar(
          context, key, 'debes ingresar los datos todos los campos');
      return;
    }
    if (repeatpassd != passd) {
      util.BarraMsg.showSnackbar(
          context, key, 'las contraseñas digitadas debe ser iguales');
      return;
    }
    if (passd.length < 6) {
      util.BarraMsg.showSnackbar(
          context, key, 'el password no tiene que ser minimo de 6 caracreres');
      return;
    }

       _progressDialog.show();

    try {
      bool sregistro = await _authProvider.registro(email, passd);

      if (sregistro) {
// objeto de tipo customer

        Messenger messenger = new Messenger(

          id: _authProvider.getUser().uid, //obtniendo el id
          email: _authProvider.getUser().email, //obteniendo el email
          placa: placa,
          name: name,
          mobil: mobil,
          passd: passd,
        
        );

// await para registro de de json el cual reciebe un obeto de tipo mensajero
//
        await _messengerProvider.create(messenger);
          _progressDialog.hide();
           Navigator.pushNamedAndRemoveUntil(context, 'mensajero/mapa', (route) => false);
          util.BarraMsg.showSnackbar(context, key, 'Registered user successfully');

//

       
      } else {
        print('informacion no guardada');
      }

      // declaramos una varibale boolena para que nos guarde lo que retorne la consulta
      // bool mregis = await _authProvider.

    } catch (error) {
      util.BarraMsg.showSnackbar(context, key, 'Error: $error');
         }
  }
}
