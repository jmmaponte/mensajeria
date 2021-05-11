import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
// Define un widget de formulario personalizado
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:formulario/src/Inicio/controladorInicio.dart';

class MiCasa extends StatefulWidget {
// llamanos al conytrolador
// y lo instanciamos

  @override
  _MicasaState createState() => _MicasaState();
}

class _MicasaState extends State<MiCasa> {
  MiController conx = new MiController();

@override
     void   initState() {
    super.initState();
    // llamamos el metodo schulde
     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      //incializamos en controlador de login
      // controler login
        conx.init(context);
    });
  }



  @override
  Widget build(context) {
    // incializamos nuestro controlador
    conx.init(context);
    return Scaffold(
      backgroundColor: Colors.lime,
      //centrar texto appBar
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ('DOMICILIOS'),
        ),
      ),

      body: SafeArea(
        child: Column(children: [
          clipper(context),
          SizedBox(height: MediaQuery.of(context).size.width * 0.1),
          textoUsuario('SELECCIONE SU PERFIL'),
          SizedBox(height: MediaQuery.of(context).size.width * 0.03),
          imgUser(context, 'img/clientes.png', 'cliente'),
          SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          // llaman el metodo creado
          textoUsuario('CLIENTES'),
          //// la otra imagen
           SizedBox(height: MediaQuery.of(context).size.width * 0.05),
          imgUser(context, 'img/domici.png',  'mensajero'),
          SizedBox(height: MediaQuery.of(context).size.width * 0.03),
          textoUsuario(''),
          SizedBox(height: MediaQuery.of(context).size.width * 0.01),
        ]),
      ),
    );
  }

//////////// M E T O D O S //////////////////////////////
//////////// M E T O D O S //////////////////////////////

// definimos el metodo para EL  texto del usuario
  Widget textoUsuario(String nombre) {
    return Text(
      nombre,
      style: TextStyle(
        fontFamily: 'Black',
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.white70,
      ),
    );
  }

  Widget imgUser(BuildContext context, String imagenUser, String typeUser) {
    return GestureDetector(
      // llamamos el metodo desde nuestro controlador y le pasamos
      // el parametro del tipo de usuario
      onTap: ()=>  conx.iraPagina(typeUser),
      
      child: CircleAvatar(
        backgroundImage: AssetImage(imagenUser),
        radius: 50,
        backgroundColor: Colors.red,
      ),
    );
  }

  Widget clipper(BuildContext context) {
    return ClipPath(
      clipper: WaveClipperTwo(),
      child: Container(
        height: MediaQuery.of(context).size.width * 0.35,
        color: Colors.purple,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // children para varios elementos
          children: [
            Image.asset('img/messenger.png'),
            Text('Bueno, Bonito  y Barato',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20,
                    fontWeight: FontWeight.w800)),
          ],
        ),
        
      ),
    );
  }
}
// Crea una clase State correspondiente. Esta clase contendrá los datos relacionados con
// e
