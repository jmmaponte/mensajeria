import 'package:flutter/material.dart';
// clase
class BarraMsg {
  // metodo que tienes tres arguemntos, contexto, key global y un texto
static void showSnackbar(BuildContext context, GlobalKey<ScaffoldState> key, String text) {
    // validamos que ninguno  de  los tres sean nulos
  if (context == null) return;
  if (key == null) return;
  if (key.currentState == null) return;
 
 // hacemos fotos en raango de elemntos del scanfold
 
  FocusScope.of(context).requestFocus(new FocusNode());
  // si ya la barra en el estado actual  la quitamos 
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    // la revovamos y la dibujamoss  
  ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 14
      ),
    ),
    backgroundColor: Colors.orange,
    // duracion del mensaje
    duration: Duration(seconds: 3)
  ));
 }
}

// vamos a ver como se implmenta
