import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/models/reward.dart';

// ignore: must_be_immutable
class RewardItemCard extends StatefulWidget {
  Reward reward;
  RewardItemCard({this.reward});

  @override
  _RewardItemCardState createState() => _RewardItemCardState();
}

class _RewardItemCardState extends State<RewardItemCard> {
  int points;
  Future<void> _showMyDialog() async {
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
                  style: TextStyle(color: Colors.black),
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

  @override
  // ignore: must_call_super
  void initState() {
    points = int.parse(widget.reward.points ?? '0');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          if (healthPoints >= points) {
            setState(() {
              healthPoints -= points;
            });
            myRewards.add(widget.reward);
            Fluttertoast.showToast(
              msg:
                  'You have got the reward successfully, please find you coupon in coupon section',
              backgroundColor: Colors.white,
              textColor: Colors.green,
              timeInSecForIosWeb: 5,
            );
          } else {
            _showMyDialog();
          }
        },
        child: Container(
          height: 80,
          width: MediaQuery.of(context).size.width / 1.2,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.cyan[400],
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                child: Image.asset('assets/images/anonymous.png'),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8)),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.reward.owner,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    widget.reward.product,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    widget.reward.points,
                    style: TextStyle(color: Colors.white),
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
