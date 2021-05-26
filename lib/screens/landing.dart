import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/menu/main.dart';
import 'package:steps_tracker_prototype/models/user.dart';

class Landing extends StatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  List<bool> isHighlighted = [true, false, false, false, false, false];
  String username;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserData>(context);
    setState(() {
      if (user?.name == null || user?.name == '') {
        username = 'guest';
      } else {
        username = user.name;
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Healthy'),
        elevation: 0,
        backgroundColor: secondaryColor,
      ),
      drawer: MainMenu(isHighlighted),
      body: Container(
        child: Column(
          children: [
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
                        color: Colors.grey[500],
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
                        color: secondaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Text('Hey ${username}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
