
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
// importamos los paqquetes
class GeofirebaseProvider {

   CollectionReference _ref;
  Geoflutterfire _geo;

  GeofirebaseProvider() {
    _ref = FirebaseFirestore.instance.collection('Ubicaciones');
    _geo = Geoflutterfire();
  }
// obtemos los  datos en tiempo real de lo que acabamos de crear ne firebase y veroccamos si enta grabado o eliminado
  Stream<DocumentSnapshot> getUbicacionByIdStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }
 // guarda la poscion en la coleccion 
  Future<void> create(String id, double lat, double lng) {
    GeoFirePoint myUbication = _geo.point(latitude: lat, longitude: lng);
    return _ref.doc(id).set({'status': 'cliente', 'position': myUbication.data});
  }
// borra la poscion inicial de fireabase
  Future<void> borrar(String id) {
    return _ref.doc(id).delete();
  }

}