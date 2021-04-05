import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:formulario/src/Inicio/controladorInicio.dart';
import 'package:formulario/src/Logon/controlerLogon.dart';

class MyLogin extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyLogin> {

  // controladotres
  ControlLogin conn = new ControlLogin();
  
// metodo para inciar el contrlalor

  void iniState() {
    super.initState();
    // llamamos el metodo schulde
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //incializamos en controlador de login
      conn.init(context); // controler login
      
    });
  }



   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          // llamamos metodos
          clipper(),
          textoLogin(),
          textoLogindos(),
          SizedBox(height: MediaQuery.of(context).size.width * 0.26),
          inputEmail(),
          inputpass(),
          buttonEnvioLogin(),
          sincuenta(conn),
        ]),
      ),
    );
  }

// metodos o wdget

  Widget buttonEnvioLogin() {
    return Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 9),
        child: ElevatedButton(
           onPressed: conn.logon,
              child: Text('Iniciar Session'),
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // background
              onPrimary: Colors.white, // foreground
            ),
            
           
            ));
  }

  // fin boton

  Widget inputEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        autofocus: true ,
        controller: conn.correocontroler,
        decoration: InputDecoration(
            //  hintText: 'Tucorreo@otulook.com',
            labelText: 'ingrese su correo electronico',

            // prefixIcon a la izquierda
            suffixIcon: Icon(
              Icons.email_outlined,
              color: Colors.amber,
            )),
      ),
    );
  }
  //texto

  Widget sincuenta(context) {
    return Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 9),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red, // background
              onPrimary: Colors.white, // foreground
            ),
            child: Text('Please Register'),
            onPressed: () {
              conn.iraRegistro();
            }));
  }

  Widget inputpass() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(autofocus: true,
        controller: conn.passdcontroler,
        obscureText: true,
        decoration: InputDecoration(
            //  hintText: 'Tucorreo@otulook.com',
            labelText: 'ingrese su contraseña',

            // prefixIcon a la izquierda
            // materual icons
            suffixIcon: Icon(
              Icons.lock_open_outlined,
              color: Colors.amber,
            )),
      ),
    );
  }

  Widget textoLogin() {
    return Container(
      alignment: Alignment.centerLeft,
      // hay otro metodos como simetryc, only // investigar
      margin: EdgeInsets.all(10),
      child: Text(
        'hola estamOS en el logon ',
        style:
            TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'Cornela'),
      ),
    );
  }

  Widget textoLogindos() {
    return Container(
      alignment: Alignment.center,
      // hay otro metodos como simetryc, only // investigar
      margin: EdgeInsets.all(10),
      child: Text(
        'yo soy el LOGON',
        style: TextStyle(
            color: Colors.black45, fontSize: 22, fontFamily: 'Cornela'),
      ),
    );
  }

  Widget clipper() {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.23,
        color: Colors.orange,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          // children para varios elementos
          children: [
            Image.asset(
              'img/messenger.png',
            ),
            Text('bueno, bonito  y barato',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );

    // metodos user y password
  }
  // metodos de validacion
  
}
