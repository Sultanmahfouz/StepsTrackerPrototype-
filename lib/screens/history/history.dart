import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/menu/drawer.dart';

import 'card/list.dart';

// ignore: must_be_immutable
class HistoryMain extends StatelessWidget {
  List<bool> isHighlighted = [false, false, false, false, false, true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'History',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      drawer: MyDrawer(isHighlighted),
      body: Padding(
        padding: EdgeInsets.only(top: 40),
        child: HistoryListCard(),
      ),
    );
  }
}
