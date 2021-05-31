import 'package:flutter/material.dart';

class DialogMessages {
  Future<void> inabilityActionMessage(
      BuildContext context, int points, int healthPoints) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          backgroundColor: Colors.white,
          title: Text(
            'Error',
            style: TextStyle(color: Colors.red),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'You need ${points - healthPoints} more points to get this reward, take more steps to gain more points and get in shape',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              child: Container(
                height: 25,
                width: 70,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'Noted',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
