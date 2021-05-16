import 'package:flutter/material.dart';

Color primaryColor = Color(0xFF1CA0DE);
Color secondaryColor = Color(0xFF24A0A7);

// Authentication components

var decorationLayout = BoxDecoration(
  gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        primaryColor,
        secondaryColor,
      ]),
);

var textHeaderStyle = TextStyle(
  color: Colors.white,
  fontSize: 30,
  letterSpacing: 2.0,
);

var fieldDecoration = InputDecoration(
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(color: primaryColor, width: 2),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    borderSide: BorderSide(color: primaryColor, width: 2),
  ),
  prefixIcon: Icon(
    Icons.email,
    color: primaryColor,
  ),
  labelText: 'Email',
  labelStyle: TextStyle(
    color: primaryColor,
  ),
  fillColor: Colors.white,
  filled: true,
);

int healthPoints = 0;
