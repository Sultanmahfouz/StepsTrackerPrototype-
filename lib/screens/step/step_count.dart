import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/app_localization.dart';
import 'package:steps_tracker_prototype/menu/drawer.dart';
import 'package:intl/intl.dart';
import 'package:steps_tracker_prototype/services/step.dart';

class StepCounter extends StatefulWidget {
  @override
  _StepCounterState createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  List<bool> isHighlighted = [false, false, false, true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        title: Text(
          AppLocalizations.of(context).getTitle("steps_appBar"),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      drawer: MyDrawer(isHighlighted),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 40,
                child: Center(
                  child: Text(
                    AppLocalizations.of(context).getTitle("number_of_steps"),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  StepCounting.steps,
                  style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // delete it later
              Center(
                child: Text(
                  DateFormat('EEE, MMM d yyyy ').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
