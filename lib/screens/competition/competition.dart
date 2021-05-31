import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/menu/drawer.dart';
import 'package:steps_tracker_prototype/models/user.dart';
import 'package:steps_tracker_prototype/screens/competition/card/list.dart';
import 'package:steps_tracker_prototype/services/competition.dart';

// ignore: must_be_immutable
class Competitions extends StatefulWidget {
  final List<UserData> allUsers;

  Competitions({this.allUsers});

  static final id = 'competition_screen';

  @override
  _CompetitionsState createState() => _CompetitionsState();
}

class _CompetitionsState extends State<Competitions> {
  List<bool> isHighlighted = [false, true, false, false, false, false, false];
  List<UserData> currentUsers = [];

  @override
  Widget build(BuildContext context) {
    currentUsers = CompetitionServices(widget.allUsers).sortUsersFootsteps();

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          'Competition',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      drawer: MyDrawer(isHighlighted),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 8,
                      left: 30,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Rankings',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 23,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              widget.allUsers?.length != null
                  ? widget.allUsers.length != 0
                      ? Padding(
                          padding: EdgeInsets.only(top: 40),
                          child: RankingListCard(
                            allUsers: currentUsers.reversed.toList(),
                          ),
                        )
                      : Container(
                          child: Text('No competitors !'),
                        )
                  : Container(
                      child: Text('Not available !'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
