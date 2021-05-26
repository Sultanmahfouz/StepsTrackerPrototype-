import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/models/menu.dart';
import 'package:steps_tracker_prototype/models/user.dart';
import 'package:steps_tracker_prototype/screens/authentication/main_auth.dart';
import 'package:steps_tracker_prototype/screens/competition/main.dart';
import 'package:steps_tracker_prototype/screens/coupons/coupons.dart';
import 'package:steps_tracker_prototype/screens/landing/landing.dart';
import 'package:steps_tracker_prototype/screens/rewards/main.dart';
import 'package:steps_tracker_prototype/screens/step/step_count.dart';
import 'package:steps_tracker_prototype/screens/settings/settings.dart';
import 'package:steps_tracker_prototype/services/auth.dart';

// ignore: must_be_immutable
class MyDrawer extends StatefulWidget {
  List<bool> isHighlighted;
  MyDrawer(this.isHighlighted);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List<Widget> widgets = [
    Landing(),
    MainCompetition(),
    MainReward(),
    StepCounter(),
    Coupons(),
    SettingsScreen(),
  ];
  List<MenuElement> menuElements = [
    MenuElement(
      title: 'Home',
      icon: Icon(
        Icons.person,
        color: Colors.white,
      ),
    ),
    MenuElement(
        title: 'Competition',
        icon: Icon(
          Icons.directions_walk_rounded,
          color: Colors.white,
        )),
    MenuElement(
      title: 'Rewards',
      icon: Icon(
        Icons.card_giftcard_sharp,
        color: Colors.white,
      ),
    ),
    MenuElement(
      title: 'Steps',
      icon: Icon(
        Icons.directions_walk_outlined,
        color: Colors.white,
      ),
    ),
    MenuElement(
      title: 'Coupons',
      icon: Icon(
        Icons.code,
        color: Colors.white,
      ),
    ),
    MenuElement(
      title: 'Settings',
      icon: Icon(
        Icons.settings,
        color: Colors.white,
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);

    return Drawer(
      child: Container(
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
            Padding(
              padding: EdgeInsets.only(top: 100, bottom: 20),
              child: CircleAvatar(
                radius: 35,
                backgroundImage: isAnon
                    ? AssetImage('assets/images/anonymous.png')
                    : user?.avatar == null || user?.avatar == ''
                        ? AssetImage('assets/images/anonymous.png')
                        : NetworkImage(user?.avatar),
              ),
            ),
            Text(isAnon ? 'Guest' : user?.name ?? ''),
            isAnon
                ? Container()
                : Text(FirebaseAuth.instance.currentUser?.email ?? ''),
            Container(
              height: 400,
              child: ListView.builder(
                itemCount: menuElements.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      for (int i = 0; i < widget.isHighlighted.length; i++) {
                        if (index == i) {
                          if (widget.isHighlighted[i] == true) {
                            Navigator.pop(context);
                          } else {
                            if (index == 3) {
                              Navigator.pop(context);
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => widgets[i]),
                            );
                          }
                        }
                        setState(() {
                          if (index == i) {
                            widget.isHighlighted[index] = true;
                          } else {
                            widget.isHighlighted[i] = false;
                          }
                        });
                      }
                    },
                    child: Container(
                      decoration: widget.isHighlighted[index]
                          ? BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20))
                          : null,
                      child: ListTile(
                        leading: menuElements[index].icon,
                        dense: true,
                        title: Text(
                          menuElements[index].title,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width / 3.2,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.grey),
                  ),
                  elevation: 4,
                  color: Colors.red,
                  onPressed: () {
                    AuthService().signOutUser();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainAuthendication()),
                    );
                  },
                  child: Center(
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
