// contralador
import 'package:flutter/material.dart';
import 'package:formulario/src/Utilidades/sharePreferences.dart';
import 'package:formulario/src/provedores/authenProv.dart';

class MiController {
  BuildContext context;

  SharePreferences _sharePre;
  Authprovider authprover;
  String _typeUser;
  // nincializa variables y confgiuraciones
  Future init(BuildContext context)  async{
    this.context = context;
    // instaciamos la clase

    _sharePre = new SharePreferences();
    authprover = new Authprovider();
    _typeUser = await _sharePre.read('typeUser');
  
  }

// creamos el metodo de typo de usuario-perfil
  void checkIfUserAth() {
    bool isSingnedId = authprover.isSingIn();
    if (isSingnedId) {
      if (_typeUser == 'cliente') {
        Navigator.pushNamedAndRemoveUntil(
            context, 'cliente/mapa', (route) => false);
      } else
        Navigator.pushNamedAndRemoveUntil(
            context, 'mensajero/mapa', (route) => false);
    }
  }



// metodo navegacion entre actividades o pagina ojo se llama el metodos de imagnes
  void iraPagina(String typeUser) {
    // llamammos el memtodo
    guardarTipoUsuario(typeUser);
    Navigator.pushNamed(context, 'login');
  }

  //metodo  para guardar las preferencias del tipo de

  void guardarTipoUsuario(String typeUser) async {
    await _sharePre.guardar('typeUser', typeUser);
  }
}
