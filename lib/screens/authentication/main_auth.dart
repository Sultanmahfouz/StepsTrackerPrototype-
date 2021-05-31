import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/models/user.dart';
import 'package:steps_tracker_prototype/screens/authentication/login.dart';
import 'package:steps_tracker_prototype/screens/authentication/registration.dart';
import 'package:steps_tracker_prototype/services/auth.dart';
import 'package:steps_tracker_prototype/services/user.dart';

import '../user_info.dart';

class MainAuthendication extends StatefulWidget {
  static String id = 'auth_screen';

  @override
  _MainAuthendicationState createState() => _MainAuthendicationState();
}

class _MainAuthendicationState extends State<MainAuthendication> {
  bool showSpinner = false;
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).scaffoldBackgroundColor,
                  Theme.of(context).scaffoldBackgroundColor,
                  secondaryColor,
                ]),
          ),
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 200.0),
                  child: Text(
                    'HEALTHY LOGO',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: Container(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width / 1.5,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.grey),
                      ),
                      elevation: 4,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 6.0),
                          child: Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width / 1.5,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.grey),
                      ),
                      elevation: 4,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Registeration()),
                        );
                      },
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 6.0),
                          child: Text(
                            'SIGN UP',
                            style: TextStyle(
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    dynamic result = await _auth.signInAnon();
                    if (result == null) {
                      print('error');
                    } else {
                      UserService(uid: FirebaseAuth.instance.currentUser.uid)
                          .setUserData(
                        UserData(
                            uid: FirebaseAuth.instance.currentUser.uid,
                            name: 'guest',
                            avatar: '',
                            footSteps: '0'),
                      );
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => GetInfo()));
                      setState(() {
                        showSpinner = false;
                        isAnon = true;
                      });
                    }
                  },
                  child: Text(
                    'Join as a guest',
                    style: TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
