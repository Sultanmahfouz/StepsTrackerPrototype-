import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/models/user.dart';
import 'package:steps_tracker_prototype/screens/authentication/main_auth.dart';
import 'package:steps_tracker_prototype/services/reward.dart';
import 'package:steps_tracker_prototype/services/user.dart';
import 'package:steps_tracker_prototype/start.dart';
import 'Theme/theme_provider.dart';
import 'models/reward.dart';
import 'package:provider/provider.dart';

import 'screens/authentication/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return StreamProvider<UserData>.value(
          value: UserService().user,
          child: StreamProvider<List<Reward>>.value(
            value: RewardsService().getAvailableRewards(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode: themeProvider.themeMode,
              theme: MyTheme.lightTheme,
              darkTheme: MyTheme.darkTheme,
              initialRoute: FirebaseAuth.instance.currentUser?.uid == null ||
                      FirebaseAuth.instance.currentUser?.isAnonymous == true
                  ? MainAuthendication.id
                  : StartApp.id,
              routes: {
                MainAuthendication.id: (context) => MainAuthendication(),
                Login.id: (context) => Login(),
                StartApp.id: (context) => StartApp(),
              },
              home: FirebaseAuth.instance.currentUser?.uid == null
                  ? MainAuthendication()
                  : StartApp(),
            ),
          ),
        );
      },
    );
  }
}
