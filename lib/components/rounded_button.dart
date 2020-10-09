import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {this.title,
      this.buttonColour,
      this.textColour = Colors.white,
      this.borderColour,
      @required this.onPressed});

  final Color buttonColour;
  final Color textColour;
  final Color borderColour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: buttonColour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: borderColour),
              borderRadius: BorderRadius.circular(30.0)),
          onPressed: onPressed,
          minWidth: 40.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              color: textColour,
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
    );
  }
}
