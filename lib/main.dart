import 'package:flutter/material.dart';
import 'package:formulario/src/Inicio/inicioPagina.dart';
import 'package:formulario/src/Logon/loginPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:formulario/src/perfiles/cliente/map/mapClientePage.dart';
import 'package:formulario/src/perfiles/cliente/registro/clienteRegistroPage.dart';
import 'package:formulario/src/perfiles/mensajero/map/mapMesajertoPage.dart';
import 'package:formulario/src/perfiles/mensajero/registro/mensajeroRegistroPage.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
// buils retona un widget
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Dolle',
          // tema de app para dehar la barra del misco color  de
          // la actividad
          appBarTheme: AppBarTheme(
            elevation: 0,
          ),
          primaryColor: Colors.orange),
      home: Micasa(),
      routes: {
        '/login': (BuildContext context) => MyLogin(),
        'cliente/registro': (BuildContext context) => ClienteMyRegistro(),
        'mensajero/registro': (BuildContext context) => MesanjeroMyRegistro(),
        'cliente/mapa': (BuildContext context) => MapCliente(),
        'mensajero/mapa': (BuildContext context) => MapMessenger(),
      },
    );
  }
}
