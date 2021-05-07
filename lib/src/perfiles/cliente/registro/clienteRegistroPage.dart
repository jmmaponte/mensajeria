import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'clienteControlerRegistro.dart';


class ClienteMyRegistro extends StatefulWidget {
  @override
  _State createState() => _State();
}

ClienteControlRegistro conr = new ClienteControlRegistro();

class _State extends State<ClienteMyRegistro> {
  @override
  Widget build(BuildContext context) {
    conr.init(context);
    return Scaffold(
      // inmportamos la lleve global 
      key: conr.key,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(children: [
          // llamamos metodos
          clipper(context),
          textoLogin(),
          textoLogindos(),
          // SizedBox(height: 40,),
          inputName(),
          inputmobil(),
          inputEmail(),
          inputpass(),
          inputRepeatPass(),
          buttonEnvioRegistro(context),
          //  sincuenta(),
        ]),
      ),
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
          child: Text('Guarde sus datos'),
          onPressed: conr.registro,
        ));
  }

  // fin boton
  //
  //
  //
  //

  Widget inputName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        autofocus: true,
        keyboardType: TextInputType.text,
        controller: conr.namecontroler,
        decoration: InputDecoration(
            //  hintText: 'Tucorreo@otulook.com',
            labelText: 'Digite su nombre por favor',

            // prefixIcon a la izquierda
            suffixIcon: Icon(
              Icons.person,
              color: Colors.amber,
            )),
      ),
    );
  }

  Widget inputmobil() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        keyboardType: TextInputType.number,
        controller: conr.mobilcontroler,
        decoration: InputDecoration(
            //  hintText: 'Tucorreo@otulook.com',
            labelText: 'Digite su numero celular',

            //   prefixIcon a la izquierda
            suffixIcon: Icon(
              Icons.person_add,
              color: Colors.amber,
            )),
      ),
    );
  }
  //texto

  Widget inputEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        autofocus: true,
        keyboardType: TextInputType.emailAddress,
        controller: conr.correocontroler,
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

  // Widget sincuenta() {
  // return Container(
  //   width: double.maxFinite,
  //   margin: EdgeInsets.symmetric(horizontal: 30, vertical: 9),
  //  child: ElevatedButton(
  //    style: ElevatedButton.styleFrom(
  //     primary: Colors.red, // background
  //     onPrimary: Colors.white, // foreground
  //  ),
  //  child: Text('REGISTRASE'),
  //  onPressed: () {
  //  conx.iraRegistro();
  //  },
  // ));
  // }

  Widget inputpass() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        obscureText: true,
        controller: conr.passdcontroler,
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

  Widget inputRepeatPass() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: TextField(
        controller: conr.repeatpassdcontroler,
        obscureText: true,
        decoration: InputDecoration(
            //  hintText: 'Tucorreo@otulook.com',
            labelText: 'Confirme sus contraseña',

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
        'yo soy el registro',
        style: TextStyle(
            color: Colors.black45, fontSize: 22, fontFamily: 'Cornela'),
      ),
    );
  }

  Widget clipper(context) {
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
  }
    // metodos user y password
  }

