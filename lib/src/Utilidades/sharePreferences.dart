import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharePreferences {
  // recibe dos argumentos la llave del form el valor qque guardaremos
  // // como un ojbeto json llave valor
  void guardar(String key, String value) async {
// traeremos la preferciencias que tenemos en ese instante
    final preferencias = await SharedPreferences.getInstance();
    preferencias.setString(key, json.encode(value));
  }

// lop gaurdamosn en un json
  Future<dynamic> read(String key) async {
    final preferencias = await SharedPreferences.getInstance();
    if (preferencias.getString(key) == null) return null;
    return jsonDecode(preferencias.getString(key));
  }

// lo valdiamos
  // si existe la llave con un valor no debe devolver un valor
  // boleano false p true
  Future<bool> contains(String key) async {
    final preferencias = await SharedPreferences.getInstance();
    return preferencias.containsKey(key);
  }

  // ahora creamos el metodo para remnover le metodo del cache del celular o movil
  //nos regresa on boool si lo borrro o no lo borrro
  Future<bool> remove(String key) async {
    final preferencias = await SharedPreferences.getInstance();
    return preferencias.remove(key);
  }
}
