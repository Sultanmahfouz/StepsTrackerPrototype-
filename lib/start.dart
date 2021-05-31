import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/models/history.dart';
import 'package:steps_tracker_prototype/screens/landing/landing.dart';
import 'package:steps_tracker_prototype/services/step.dart';
import 'package:steps_tracker_prototype/services/user.dart';
import 'Theme/theme_provider.dart';
import 'app_localization.dart';
import 'components/constants.dart';
import 'models/user.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class StartApp extends StatefulWidget {
  static String id = 'start_screen';

  @override
  _StartAppState createState() => _StartAppState();
}

class _StartAppState extends State<StartApp> {
  Stream<StepCount> _stepCountStream;

  bool initial = true;
  int currentStep = 0;
  int initialStep = 0;
  bool isHealthPoint = false;
  bool exchangePointsOccured = false;
  int trigger = 1;

  void onStepCount(StepCount event) {
    setState(() {
      if (initial) {
        initialStep = event.steps;
        initial = false;
      }
      currentStep = event.steps;
      StepCounting.steps = event.steps.toString();

      UserService(uid: FirebaseAuth.instance.currentUser.uid)
          .updateUserDataSteps(currentStep.toString());

      exchangePointsOccured = exchangePoints();

      if (healthPoints > 34 && trigger == 1) {
        userHistory.add(
          History(
            points: 35,
            exchangeDate: DateTime.now(),
            owner: '',
            kind: 'gained',
          ),
        );
        setState(() {
          showNotification();
          trigger = 0;
        });
      }
      if (exchangePointsOccured) {
        setState(() {
          initialStep = currentStep;
        });
      }
    });
  }

  // exchange footsteps with health points that can be user for rewards
  bool exchangePoints() {
    int allStepsTaken = currentStep - initialStep;

    // assuming the person has a taget of 10,000 steps a day not more
    if (allStepsTaken > 10 && healthPoints <= 1000) {
      healthPoints += 1;
      allStepsTaken -= 10;
      return true;
    }
    return false;
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      StepCounting.steps = 'Step Count is not available';
    });
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  InitializationSettings initilizationSettings;

  void showNotification() async {
    await demoNotification();
  }

  Future<void> demoNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(0, 'Congratulations',
        'You have got +35 points', platformChannelSpecifics,
        payload: 'test oayload');
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    showLanguage();
    var initilizationSettingsAndroid =
        new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initilizationSettingsIOS = new IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    initilizationSettings = new InitializationSettings(
      initilizationSettingsAndroid,
      initilizationSettingsIOS,
    );
    flutterLocalNotificationsPlugin.initialize(initilizationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future<void> showLanguage() async {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('Notification payload: $payload');
    }
    await Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new SecondRoute()));
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () async {
                    Navigator.of(context, rootNavigator: true).pop();
                    await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SecondRoute()));
                  },
                )
              ],
            ));
  }

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
              home: Landing(),
            );
          },
        ),
      ),
    );
  }
}
