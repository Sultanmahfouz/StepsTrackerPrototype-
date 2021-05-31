import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/menu/main.dart';
import 'package:steps_tracker_prototype/models/user.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  List<bool> isHighlighted = [true, false, false, false, false, false];
  String username;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  InitializationSettings initilizationSettings;

  void _showNotification() async {
    await _demoNotification();
  }

  Future<void> _demoNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name', 'channel description',
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'test ticker');

    var iOSChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0, 'دعاء', 'لا اله الا الله وحده لا شريك له', platformChannelSpecifics,
        payload: 'test oayload');
  }

  @override
  void initState() {
    super.initState();
    username = 'guest';
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    if (user != null) {
      username = user.name ?? 'guest';
      return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          iconTheme: Theme.of(context).iconTheme,
          title: Text(
            'Healthy',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        drawer: MainMenu(isHighlighted),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
                secondaryColor,
              ],
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Image.asset('assets/images/header.jpeg'),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: isAnon
                            ? AssetImage('assets/images/anonymous.png')
                            : user?.avatar == null || user?.avatar == ''
                                ? AssetImage('assets/images/anonymous.png')
                                : NetworkImage(user?.avatar),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 14),
                        child: Text(
                          'Hey ',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          username.length > 15
                              ? username.substring(0, 15) + '..!'
                              : username + ' !',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Text('Hey ${username}'),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Container(
                    height: 40,
                    child: Text(
                      'Welcome to Healthy App',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 10,
                  thickness: 4,
                  indent: 150,
                  endIndent: 150,
                  color: Theme.of(context).primaryColor,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50, horizontal: 100),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.grey),
                    ),
                    elevation: 4,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      _showNotification();
                      print('should show notification');
                    },
                    // onPressed: () {
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => MainReward()),
                    //   );
                    // },
                    child: Center(
                      child: Text(
                        'START',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          child: Center(),
        ),
      );
    }
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('route 2'),
      ),
      body: Center(
        child: GestureDetector(
          child: Text('Go Back ...'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
