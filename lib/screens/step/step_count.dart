import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/menu/drawer.dart';
import 'package:steps_tracker_prototype/services/user.dart';

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
  int totalPoints = 0;
  bool isHealthPoint = false;
  bool exchangePointsOccured = false;
  List<bool> isHighlighted = [false, false, true, false, false];

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
      UserService().updateUserDataSteps(currentStep.toString());

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
    if (allStepsTaken > 10 && totalPoints <= 1000) {
      totalPoints += 1;
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
      backgroundColor: Color(0xFF252938),
      appBar: AppBar(
        title: Text('Steps'),
        backgroundColor: Color(0xFF252938),
        elevation: 0,
      ),
      drawer: MyDrawer(isHighlighted),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularPercentIndicator(
                animateFromLastPercent: true,
                center: Center(
                  child: Text(
                    totalPoints.toString() + '  /' + '  1000',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4849BF),
                      fontSize: 25,
                    ),
                  ),
                ),
                backgroundColor: Colors.grey[300],
                radius: 280.0,
                progressColor: Color(0xFF4849BF),
                // percent: (1 / 7.0) * TawafCounting.lapCountOrientation,
                percent: (1 / 1000.0) * totalPoints,
                animation: true,
                lineWidth: 14,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF282F3F),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white),
                ),
                width: 169,
                height: 40,
                child: Center(
                  child: Text(
                    'number of steps',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Text(
                _steps,
                style: TextStyle(fontSize: 50, color: Colors.white),
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
                    totalPoints.toString(),
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
