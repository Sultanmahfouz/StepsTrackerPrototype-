import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/screens/authentication/login.dart';
import 'package:steps_tracker_prototype/screens/user_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetInfo(),
    );
  }
}
