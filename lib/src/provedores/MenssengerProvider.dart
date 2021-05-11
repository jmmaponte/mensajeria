import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formulario/src/modelos/Messenger.dart';


class MessengerProvider {

  CollectionReference _ref;

  MessengerProvider() {
    _ref = FirebaseFirestore.instance.collection('Messenger');
  }

  Future<void> create(Messenger messenger) {
    String errorMessage;

    try {
      return _ref.doc(messenger.id).set(messenger.toJson());
    } catch(error) {
      errorMessage = error.code;
    }

    if (errorMessage != null) {
      return Future.error(errorMessage);
    }

  }

  Stream<DocumentSnapshot> getByIdStream(String id) {
    return _ref.doc(id).snapshots(includeMetadataChanges: true);
  }

  Future<Messenger> getById(String id) async {
    DocumentSnapshot document = await _ref.doc(id).get();

    if (document.exists) {
      Messenger driver = Messenger.fromJson(document.data());
      return driver;
    }

    return null;
  }

}