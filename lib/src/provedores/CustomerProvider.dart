//creamos la clase del customerr(cliente)
import '../modelos/Customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomerProvider {
  // creamos la coleccion cual inmediatamente me importa el paquete,
  // la bautizamos paara manipularla
  CollectionReference _ref;

  // Creamos el constructor
  CustomerProvider() {
    // Inicalizamos la variable  de la coleccion como una instacia
    // de fierbase firestore con nuestra coleccion de datos
    // del customer

    _ref = FirebaseFirestore.instance.collection('Customers');
  }
//Ahor avamos a crear el método para agregar información a la colección o base de datos
// el metodo create de tipo de objeto customer como argumento

 Future <void> create(Customer customer) {
    // varibale para el tratamiento de error
    String errorMsg;

    try {
      // nos regresa el id con el que va quedar registrado el usuario
      // en firestore en formato json
      // retunr no va retornar lo que tenga la variable que esta apuntado a la coleccion
      return _ref.doc(customer.id).set(customer.toJson());
    } catch (error) {
      errorMsg = error.code;
    }
    if (errorMsg != null) {
      return Future.error(errorMsg);
    }
  }

// nos devere  returnar un objeto de tipo cliente
  Future<Customer> getById(String id) async {
    // consulta a la base de datos
    // con este tipo de varibale para recorra todoa la coleccion
    // en busca del id y si lo encuentra lo regrese a la variable de lo contratio diga que no existe
    DocumentSnapshot documento = await _ref.doc(id).get();
    if (documento.exists) {
      // lo pasamos el documento al un objeto customer
      Customer customer = Customer.fromJson(documento.data());
      //retornamos el objeto completo
      return customer;
    } 
      return null;
    }
  }

