import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/menu/drawer.dart';
import 'package:steps_tracker_prototype/models/user.dart';

// ignore: must_be_immutable
class Competitions extends StatefulWidget {
  final List<UserData> allUsers;

  Competitions({this.allUsers});

  static final id = 'competition_screen';

  @override
  _CompetitionsState createState() => _CompetitionsState();
}

class _CompetitionsState extends State<Competitions> {
  List<bool> isHighlighted = [false, true, false, false, false, false];
  List<UserData> currentUsers = [];

  @override
  Widget build(BuildContext context) {
    if (widget.allUsers != null && widget.allUsers?.length != 0) {
      print(widget.allUsers);
      currentUsers.addAll(widget.allUsers);

      currentUsers.sort((a, b) =>
          int.parse(a.footSteps).compareTo(int.parse(b.footSteps ?? '0')));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('Competition'),
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
                          'Competitiors',
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
              SizedBox(
                height: 30,
              ),
              widget.allUsers?.length != null
                  ? widget.allUsers.length != 0
                      ? Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: SingleChildScrollView(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: List.generate(
                                        widget.allUsers.length,
                                        (index) {
                                          return Text(currentUsers[index].name);
                                        },
                                      ),
                                    ),
                                    SizedBox(width: 200),
                                    Column(
                                      children: List.generate(
                                        currentUsers.length,
                                        (index) {
                                          return Text(
                                              currentUsers[index].footSteps);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          child: Text('length = 0 !'),
                        )
                  : Container(
                      child: Text('null !'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
