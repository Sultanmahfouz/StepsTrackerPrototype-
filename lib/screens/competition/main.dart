import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/models/user.dart';
import 'package:steps_tracker_prototype/screens/competition/competition.dart';

class MainCompetition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final allUsers = Provider.of<List<UserData>>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Competitions(
        allUsers: allUsers,
      ),
    );
  }
}
