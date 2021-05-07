import 'package:flutter/material.dart';



class ButtonApp extends StatelessWidget {

  Color color;
  Color textColor;
  String text;
  IconData icon;
  Function onPressed;

  ButtonApp({
    this.color = Colors.black,
    this.textColor = Colors.white,
    this.icon = Icons.arrow_back_ios_outlined,
    this.onPressed,
    @required this.text
  });


  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return RaisedButton(
      onPressed: () {
        onPressed();
      },
      color: color,
      textColor: textColor,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                  text,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              )
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 50,
              child: CircleAvatar(
                radius: 15,
                child: Icon(
                  icon,
                  color: Colors.amberAccent,
                ),
                backgroundColor: Colors.white,
              ),
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
    );
  }
}
