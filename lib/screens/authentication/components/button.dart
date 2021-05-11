import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/components/constants.dart';

// ignore: must_be_immutable
class AuthButton extends StatelessWidget {
  Function onPressed;
  String title;

  AuthButton({this.onPressed, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.green,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: secondaryColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
