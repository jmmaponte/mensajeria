import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class MyRegistro extends StatefulWidget  {
  //MiController conx = new MiController();

  @override
  _State createState() => _State();
}

class _State extends State<MyRegistro> {
  @override
  Widget build(BuildContext context) {
    //conx.init();
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: [
        // llamamos metodos
        clipper(),
        textoLogin(),
        textoLogindos(),
        // SizedBox(height: 40,),
        Expanded(
          child: Container(),
        ),
        inputEmail(),
        inputpass(),
        buttonEnvioRegistro(context),
        sincuenta(),
      ]),
    );
  }

// metodos o wdget

  Widget buttonEnvioRegistro(conx) {
    return Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 9),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // background
            onPrimary: Colors.white, // foreground
          ),
          child: Text('Registro de usuarios'),
          onPressed: () {
            conx.iraRegistro();
          },
        ));
  }

  // fin boton

  Widget inputEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        decoration: InputDecoration(
            //  hintText: 'Tucorreo@otulook.com',
            labelText: 'ingrese su correo elctronico',

            // prefixIcon a la izquierda
            suffixIcon: Icon(
              Icons.email_outlined,
              color: Colors.amber,
            )),
      ),
    );
  }
  //texto

  Widget sincuenta() {
    return Container(
        width: double.maxFinite,
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 9),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.red, // background
            onPrimary: Colors.white, // foreground
          ),
          child: Text('REGISTRASE'),
          onPressed: () {
          //  conx.iraRegistro();
          },
        ));
  }

  Widget inputpass() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
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
        'Por favor registre sus datos ',
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
}
