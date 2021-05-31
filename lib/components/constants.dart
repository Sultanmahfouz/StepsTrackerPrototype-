import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/models/history.dart';
import 'package:steps_tracker_prototype/models/reward.dart';

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
  fillColor: Colors.white,
  filled: true,
);

int allStepsTaken = 0;

int healthPoints = 30;

bool isAnon = false;

List<Reward> userCoupons = [];

List<History> userHistory = [];
