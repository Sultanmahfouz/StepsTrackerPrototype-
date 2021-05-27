import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/menu/drawer.dart';
import 'package:steps_tracker_prototype/services/user.dart';
import 'package:intl/intl.dart';

class StepCounter extends StatefulWidget {
  @override
  _StepCounterState createState() => _StepCounterState();
}

class _StepCounterState extends State<StepCounter> {
  Stream<StepCount> _stepCountStream;

  String _steps = '?';

  bool initial = true;
  int currentStep = 0;
  int initialStep = 0;
  bool isHealthPoint = false;
  bool exchangePointsOccured = false;
  List<bool> isHighlighted = [false, false, false, true, false, false];

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  void onStepCount(StepCount event) {
    setState(() {
      if (initial) {
        initialStep = event.steps;
        initial = false;
      }
      currentStep = event.steps;
      _steps = event.steps.toString();
      UserService(uid: FirebaseAuth.instance.currentUser.uid)
          .updateUserDataSteps(currentStep.toString());

      exchangePointsOccured = exchangePoints();

      if (exchangePointsOccured) {
        setState(() {
          initialStep = currentStep;
        });
      }
    });
  }

  // exchange footsteps with health points that can be user for rewards
  bool exchangePoints() {
    allStepsTaken = currentStep - initialStep;

    // assuming the person has a taget of 10,000 steps a day not more
    if (allStepsTaken > 10 && healthPoints <= 1000) {
      healthPoints += 1;
      allStepsTaken -= 10;
      return true;
    }
    return false;
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count is not available';
    });
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

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
                  _steps,
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
                    currentStep.toString(),
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
                    initialStep.toString(),
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
