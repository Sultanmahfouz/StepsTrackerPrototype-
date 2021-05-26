import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.dark;

  bool get isDarkTheme => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyTheme {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
  );

  static final darkTheme = ThemeData(
    // scaffoldBackgroundColor: Colors.white70,
    // primaryColor: Colors.white70,
    // colorScheme: ColorScheme.light(),
    // iconTheme: IconThemeData(color: Colors.cyan, opacity: 0.9),
    scaffoldBackgroundColor: Colors.green[900],
    primaryColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.red, opacity: 0.8),
  );
}
