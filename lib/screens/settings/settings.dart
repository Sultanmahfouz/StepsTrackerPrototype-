import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/menu/main.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  List<bool> isHighlighted = [false, false, false, false, false, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        excludeHeaderSemantics: true,
        backgroundColor: Color(0xFF5D82DB),
        elevation: 0,
      ),
      drawer: MainMenu(isHighlighted),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100.0, left: 40),
            child: Text(
              'Settings',
              style: TextStyle(
                color: Color(0xFF5D82DB),
                fontSize: 25,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            height: 75,
            width: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(child: Text('Light Mode')),
                // ChangeThemeButtonWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
