import 'package:flutter/material.dart';

import 'package:steps_tracker_prototype/components/constants.dart';
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
          'Steps',
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
                    'number of steps',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'current step: ',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    StepCounting.currentStep.toString(),
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'initial step: ',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    StepCounting.initialStep.toString(),
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'total Points: ',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    healthPoints.toString(),
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
