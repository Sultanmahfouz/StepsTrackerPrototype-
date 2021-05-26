import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/screens/landing/landing.dart';
import 'package:steps_tracker_prototype/services/user.dart';

import 'Theme/theme_provider.dart';
import 'models/user.dart';

class StartApp extends StatelessWidget {
  static String id = 'start_screen';
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<UserData>>.value(
      value: UserService().getUsersFootSteps(),
      child: StreamProvider<UserData>.value(
        value: UserService()
            .getUserDocument(FirebaseAuth.instance.currentUser?.uid),
        child: ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          builder: (context, _) {
            final themeProvider = Provider.of<ThemeProvider>(context);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeProvider.themeMode,
              theme: MyTheme.lightTheme,
              darkTheme: MyTheme.darkTheme,
              home: Landing(),
            );
          },
        ),
      ),
    );
  }
}
