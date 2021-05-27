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
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Color(0xFF24A0A7),
    colorScheme: ColorScheme.light(),
    secondaryHeaderColor: Color(0xFFFAFAFA),
    iconTheme: IconThemeData(color: Colors.black, opacity: 0.8),
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: Color(0xFF24A0A7),
    secondaryHeaderColor: Colors.grey[800],
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(
      color: Colors.white,
      opacity: 0.8,
    ),
  );
}
