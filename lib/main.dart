import 'package:flutter/material.dart';
import 'package:formulario/src/Inicio/inicioPagina.dart';

import 'package:formulario/src/Logon/loginPage.dart';
import 'package:formulario/src/Registro/registroPage.dart';
import 'package:firebase_core/firebase_core.dart';

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
      home: MiCasa(),
      routes: {
        '/login': (BuildContext context) => MyLogin(),
        '/registro': (BuildContext context) => MyRegistro(),
      },
    );
  }
}
