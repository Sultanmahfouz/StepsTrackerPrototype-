import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pedometer/pedometer.dart';

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
    });
  }

  void exchangePoints(int initialStep, int currentStep) {
    int totalSteps = currentStep - initialStep;
    if (totalSteps > 10) {
      totalPoints += 1;
    }
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
    exchangePoints(initialStep, currentStep);
    return Scaffold(
      backgroundColor: Color(0xFF252938),
      appBar: AppBar(
        title: Text('Steps'),
        backgroundColor: Color(0xFF252938),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              Text(
                currentStep.toString(),
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
              Text(
                totalPoints.toString(),
                style: TextStyle(fontSize: 50, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
