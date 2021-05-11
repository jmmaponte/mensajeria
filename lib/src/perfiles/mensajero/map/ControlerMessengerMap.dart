import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:formulario/src/Utilidades/progesoDialogo.dart';
import 'package:formulario/src/modelos/Messenger.dart';
import 'package:formulario/src/provedores/GeofireProvider.dart';
import 'package:formulario/src/provedores/MenssengerProvider.dart';
import 'package:formulario/src/provedores/authenProv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:formulario/src/Utilidades/barraMensajes.dart' as util;
import 'package:location/location.dart' as location;
import 'package:progress_dialog/progress_dialog.dart';



class MapControlerMessenger {
  BuildContext context;
  Function refresh;
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controlMapa = Completer();

  CameraPosition initialPosition =
      CameraPosition(target: LatLng(1.2342774, -77.2645446), zoom: 15.0);

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  Position _position;
  StreamSubscription<Position> _positionStream;

  BitmapDescriptor markerMsg;

  GeofirebaseProvider _geofireProvider;
  Authprovider _authProvider;
  Messenger messenger;
  MessengerProvider _messengerProvider;

  bool isConnectado = false;
  ProgressDialog _progressDialog;

// creamos esta varible de estipo de coleccion, para ue stren solicte los datos
// en tiempo real solo cual el usuario lo pide.
  StreamSubscription<DocumentSnapshot> _statusSuscription;
  StreamSubscription<DocumentSnapshot> _messengerInfoSuscription;
  

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    _geofireProvider = new GeofirebaseProvider();
    _authProvider = new Authprovider();

    _messengerProvider = new MessengerProvider();

    _progressDialog =
        MyDialogoProgreso.createProgressDailog(context, 'Conectandose...');

    markerMsg = await imagenMapRuta('img/delivery/client.png');
    checkGPS();
    getCustomerInf();
  }

// metodo para solicitar en tiempo real cuando se requiera
// verificando que la identificacion del usuairo sea igual en la ubicacion y
// el user logueado.


  void getCustomerInf() {
    Stream<DocumentSnapshot> msgStream =  _messengerProvider.getByIdStream(_authProvider.getUser().uid);
    _messengerInfoSuscription =  msgStream.listen((DocumentSnapshot document) {
      messenger = Messenger.fromJson(document.data());
      refresh();
    });
  }


 void openCajon() {
    key.currentState.openDrawer();
  }

   void dispobible() {
    _positionStream?.cancel();
    _statusSuscription?.cancel();
    _messengerInfoSuscription?.cancel();
  }

 

   void sigOffCustomer() async {
    await _authProvider.singOut();
    Navigator.pushNamedAndRemoveUntil(context, 'inicio', (route) => false);
  }
// crear mapa
  void mapCreate(GoogleMapController controller) {
    _controlMapa.complete(controller);
  }




  void guardarUbicacion() async {
    await _geofireProvider.create(
        _authProvider.getUser().uid, 
        _position.latitude,
         _position.longitude
         );
    _progressDialog.hide();
  }

  void conexion() {
    if (isConnectado) {
      desconnectado();
    } else {
      _progressDialog.show();
      updateLocation();
    }
  }

  void desconnectado() {
    _positionStream?.cancel();
    _geofireProvider.borrar(_authProvider.getUser().uid);
  }

// metodo patra chequear si el  usuario esta coenctado.
  void checkIfIsConnect() {
    // importar
    Stream<DocumentSnapshot> status =
        _geofireProvider.getUbicacionByIdStream(_authProvider.getUser().uid);
    _statusSuscription = status.listen((DocumentSnapshot document) {
      // comporbamos si el documento existe
      if (document.exists) {
        isConnectado = true;
      } else {
        isConnectado = false;
      }

      refresh();
    });
  }

  void updateLocation() async {
    try {
      await _determinePosition();
      _position = await Geolocator.getLastKnownPosition();
      centerPosition();
      guardarUbicacion();

      addMarker('mensajero', 
      _position.latitude, 
      _position.longitude,
          'Mi posicion', 
          '', 
          markerMsg);
      refresh();

      _positionStream = Geolocator.getPositionStream(
              desiredAccuracy: LocationAccuracy.best, distanceFilter: 1)
          .listen((Position position) {
        _position = position;
        addMarker('mesanjero', _position.latitude, _position.longitude,
            'Mu posicion', '', markerMsg);
        animateCameraToPosition(_position.latitude, _position.longitude);
        guardarUbicacion();
        refresh();
      });
    } catch (error) {
      print('Error en la localizacion: $error');
    }
  }

  void centerPosition() {
    if (_position != null) {
      animateCameraToPosition(_position.latitude, _position.longitude);
    } else {
      util.BarraMsg.showSnackbar(
          context, key, 'Activa el GPS para obtener la posicion');
    }
  }

  void checkGPS() async {
    bool isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    if (isLocationEnabled) {
      updateLocation();
      checkIfIsConnect();
    } else {
      bool locationGPS = await location.Location().requestService();
      if (locationGPS) {
        updateLocation();
        checkIfIsConnect();
      }
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Future animateCameraToPosition(double latitude, double longitude) async {
    GoogleMapController controller = await _controlMapa.future;
    if (controller != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 0, target: LatLng(latitude, longitude), zoom: 17)));
    }
  }

  Future<BitmapDescriptor> imagenMapRuta(String path) async {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor bitmapDescriptor =
        await BitmapDescriptor.fromAssetImage(configuration, path);
    return bitmapDescriptor;
  }

  void addMarker(String markerId, 
  double lat, 
  double lng, 
  String title,
    String content, 
    BitmapDescriptor iconMarker)
     {
    MarkerId id = MarkerId(markerId);
    Marker marker = Marker(
        markerId: id,
        icon: iconMarker,
        position: LatLng(lat, lng),
        infoWindow: InfoWindow(title: title, snippet: content),
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5, 0.6),
        rotation: _position.heading);

    markers[id] = marker;
  }
}
