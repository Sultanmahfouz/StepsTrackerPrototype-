import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/Theme/control.dart';
import 'package:steps_tracker_prototype/menu/main.dart';

// ignore: must_be_immutable
class SettingsScreen extends StatelessWidget {
  List<bool> isHighlighted = [false, false, false, false, false, false, true];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          'Settings',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        excludeHeaderSemantics: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                Icons.menu,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ),
      drawer: MainMenu(isHighlighted),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 60.0, left: 40),
            child: Text(
              'Display',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Dark Mode',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                ChangeThemeButtonWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
