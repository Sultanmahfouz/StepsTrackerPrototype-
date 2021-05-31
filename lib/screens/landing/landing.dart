import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/app_localization.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/menu/main.dart';
import 'package:steps_tracker_prototype/models/user.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:steps_tracker_prototype/screens/rewards/main.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  List<bool> isHighlighted = [true, false, false, false, false, false, false];
  String username;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  InitializationSettings initilizationSettings;
  Locale locale;

  void setLocale(Locale loc) {
    setState(() {
      locale = loc;
    });
  }

  @override
  void initState() {
    super.initState();
    username = 'guest';
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
            AppLocalizations.of(context).getTitle("landing_appBar"),
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
                        padding: EdgeInsets.only(left: 14, right: 14),
                        child: Text(
                          AppLocalizations.of(context)
                              .getTitle("welcoming_user"),
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
                      AppLocalizations.of(context).getTitle("welcoming_to_app"),
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
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainReward()),
                      );
                    },
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).getTitle("landing_button"),
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
