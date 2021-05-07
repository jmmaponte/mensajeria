
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formulario/src/modelos/Messenger.dart';

//creamos la clase del customerr(cliente)
class MessengerProvider {
  // creamos la coleccion cual inmediatamente me importa el paquete,
  // la bautizamos paara manipularla
  CollectionReference _ref;

  // Creamos el constructor
  MessengerProvider() {
    // Inicalizamos la variable  de la coleccion como una instacia
    // de fierbase firestore con nuestra coleccion de datos
    // del customer

    _ref = FirebaseFirestore.instance.collection('Messenger');
  }
//Ahor avamos a crear el método para agregar información a la colección o base de datos
// el metodo create de tipo de objeto customer como argumento

  Future<dynamic> create(Messenger messenger) {
    // varibale para el tratamiento de error
    String errorMsg;

    try {
      // nos regresa el id con el que va quedar registrado el usuario
      // en firestore en formato json
      // retunr no va retornar lo que tenga la variable que esta apuntado a la coleccion
      return _ref.doc(messenger.id).set(messenger.toJson());
    } catch (error) {
      errorMsg = error.code;
    }
    if (errorMsg != null) {
      return Future.error(errorMsg);
    }
  }

// nos devolver returnar un objeto de tipo messenger
  Future<Messenger> getById(String id) async {
    // consulta a la base de datos
    // con este tipo de varibale para recorra todoa la coleccion
    // en busca del id y si lo encuentra lo regrese a la variable de lo contratio diga que no existe
    DocumentSnapshot document = await _ref.doc(id).get();
    if (document.exists) {
      // lo pasamos el documento al un objeto messenger
      Messenger mensajero = Messenger.fromJson(document.data());
      //retornamos el objeto completo
      return mensajero;
    }
    return null;
  }
}
