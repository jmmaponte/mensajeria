// contralador

import 'package:flutter/material.dart';

class MiController {
  BuildContext context;
  // nincializa variables y confgiuraciones
  Future init(BuildContext context) {
    this.context = context;
  }

// metodo navegacion entre actividades o pagina ojo se llama en los metodos de imagnes
  void iraPagina() {
    Navigator.pushNamed(context, '/login');
  }


}
