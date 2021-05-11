import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:formulario/src/widgets/BotonesApp.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'ControlerMessengerMap.dart';

// creamos la clase
class MapMessenger extends StatefulWidget {
  @override
  _MessengerState createState() => _MessengerState();
}

class _MessengerState extends State<MapMessenger> {
// importamos el controlador
  MapControlerMessenger _conexm = new MapControlerMessenger();
// inciqlizamos nuestro controlador
 @override
  void initState() {
    super.initState();
// hacemos el enlace para que nos regrese le valor entro del marco
    SchedulerBinding.instance.addPersistentFrameCallback((timeStamp) {
      _conexm.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _conexm.key,
      // stack para haga pila sobre el mapa
      drawer: _cajonM(),
        body: Stack(
      children: [
       wgooGleMaps(),
        SafeArea(
            child: Column(
          children: [
            Row(
              // separa los elementos y los ubica en las esquina cada elemento
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                botonMenu(),
                botonPostionUser(),
              ],
            ),
            Expanded(child: Container()),
            botonConex(),
          ],
        )),
      ],
    ));
  }

// creamos el wibgewt de google maps
  Widget wgooGleMaps() {
   return  GoogleMap(
          mapType: MapType.normal,
          // llamamno el metodo de controler para inciualizac la poscion
          initialCameraPosition: _conexm.initialPosition,
          onMapCreated: _conexm.mapCreate,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: Set<Marker>.of(_conexm.markers.values),
        );
  
  }
  Widget botonConex() {
   return Container(
      height: 50,
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      child: ButtonApp(
        onPressed: _conexm.conexion,
        text: _conexm.isConnectado ? 'DESCONECTARSE' : 'CONECTARSE',
        color:_conexm.isConnectado ? Colors.grey[300] : Colors.amberAccent,
        textColor: Colors.black,
      ),
    );
  }
  Widget botonMenu() {
    return Container(
       alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: _conexm.openCajon,
        icon: Icon(
          Icons.menu_sharp,
          color: Colors.orange,
        ),
      ),
    );
  }
  Widget botonPostionUser() {
    return  GestureDetector(
          onTap: _conexm.centerPosition,
          child: Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.symmetric(horizontal: 6),
          child: Card(
            color: Colors.black,
            elevation: 4.0,
        shape: CircleBorder(),
        child: Container(
          padding: EdgeInsets.all(11),
          child: Icon(Icons.location_searching, 
          color: Colors.orangeAccent[700],
          size: 25),
        ),
      )),
    );
  }

 Widget   _cajonM() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [// encabezado
          DrawerHeader(
            child: Column(
              // alienear el menu y los elemtos a la izquierda
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    // validamos el campo por si es nulo o tarda mucho la base de datos en regersarlos
                    _conexm.messenger?.name ?? 'Nombre del usuario ',
                  
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),
                ),
                Container(
                  child: Text(
                       // validamos el campo por si es nulo o tarda mucho la base de datos en regersarlos
                     _conexm.messenger?.email ?? 'correo electronico',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[850],
                        fontWeight: FontWeight.bold
                    ),
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: 8),
                CircleAvatar(
                  backgroundImage: AssetImage('img/delivery/client.png'),
                  radius: 38,
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.amberAccent
            ),
          ),
          ListTile(
            title: Text('Editar perfil'),
            // Nos ubica icono y texto a la izquierda
            trailing: Icon(Icons.edit),
            // leading: Icon(Icons.cancel),
            onTap: () {},
          ),
          ListTile(
            title: Text('Cerrar sesion'),
            trailing: Icon(Icons.power_settings_new),
            // leading: Icon(Icons.cancel),
            onTap: _conexm.sigOffCustomer,
          ),
        ],
      ),
    );
  }




  // metodo que fresca pa pagina y dibija todo cada vez que se hace un update
void refresh()
{
  setState(() {});
}

}
