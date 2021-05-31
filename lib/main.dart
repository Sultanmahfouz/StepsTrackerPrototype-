import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/models/user.dart';
import 'package:steps_tracker_prototype/screens/authentication/main_auth.dart';
import 'package:steps_tracker_prototype/services/reward.dart';
import 'package:steps_tracker_prototype/services/user.dart';
import 'package:steps_tracker_prototype/start.dart';
import 'Theme/theme_provider.dart';
import 'app_localization.dart';
import 'models/reward.dart';
import 'package:provider/provider.dart';
import 'screens/authentication/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:steps_tracker_prototype/components/constants.dart';

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
  Locale _locale;

  void setLocale(Locale loc) {
    setState(() {
      _locale = loc;
    });
  }

  Locale getLocale() {
    return _locale;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      builder: (context, _) {
        final themeProvider = Provider.of<ThemeProvider>(context);
        return StreamProvider<List<UserData>>.value(
          value: UserService().getUsersFootSteps(),
          child: StreamProvider<UserData>.value(
            value: UserService().user,
            child: StreamProvider<List<Reward>>.value(
              value: RewardsService().getAvailableRewards(),
              child: MaterialApp(
                supportedLocales: [
                  Locale('en', 'US'),
                  Locale('ar', 'SA'),
                ],
                locale: language,
                // These delegates make sure that the localization data for the proper language is loaded
                localizationsDelegates: [
                  // THIS CLASS WILL BE ADDED LATER
                  // A class which loads the translations from JSON files
                  AppLocalizations.delegate,
                  // Built-in localization of basic text for Material widgets
                  GlobalMaterialLocalizations.delegate,
                  // Built-in localization for text direction LTR/RTL
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                // Returns a locale which will be used by the app
                localeResolutionCallback: (locale, supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale.languageCode) {
                      return supportedLocale;
                    }
                  }

                  // can't find any matching locale
                  return supportedLocales.first;
                },

                debugShowCheckedModeBanner: false,
                themeMode: themeProvider.themeMode,
                theme: MyTheme.lightTheme,
                darkTheme: MyTheme.darkTheme,
                initialRoute: FirebaseAuth.instance.currentUser?.uid == null
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
          ),
        );
      },
    );
  }
}
