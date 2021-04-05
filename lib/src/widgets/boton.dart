
import 'package:flutter/material.dart';



class  Botonapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
    primary: Colors.red, // background
    onPrimary: Colors.white, // foreground
     ),
      child: Text('Iniciar Session'),
      
      onPressed: () {
        print('Pressed');
      },
    )
      
    );
  }
}

