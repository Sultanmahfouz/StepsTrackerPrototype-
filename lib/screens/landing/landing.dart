import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/menu/main.dart';
import 'package:steps_tracker_prototype/models/user.dart';
import 'package:steps_tracker_prototype/screens/rewards/main.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  List<bool> isHighlighted = [true, false, false, false, false, false];
  String username;

  @override
  void initState() {
    username = 'guest';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    if (user != null) {
      username = user.name ?? 'guest';
      return Scaffold(
        appBar: AppBar(
          title: Text('Healthy'),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        drawer: MainMenu(isHighlighted),
        body: Container(
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainReward()),
                    );
                  },
                  child: Center(
                    child: Text(
                      'START',
                      style: TextStyle(
                        letterSpacing: 2.0,
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
