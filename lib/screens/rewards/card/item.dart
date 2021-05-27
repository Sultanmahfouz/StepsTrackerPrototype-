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

  String getRewardLevel(int points) {
    if (points < 25) {
      return 'silver.jpeg';
    } else if (points < 70) {
      return 'gold.jpeg';
    }
    return 'platinum.jpeg';
  }

  Color getRewardColor(int points) {
    if (points < 25) {
      return Color(0xFFC0C0C0);
    } else if (points < 70) {
      return Color(0xFFFFD700);
    }
    return Color(0xFFe5e4e2);
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
            userCoupons.add(widget.reward);
            Fluttertoast.showToast(
              msg:
                  'You have redeemed the reward successfully, please find your coupon in the coupon section',
              textColor: Colors.green,
              timeInSecForIosWeb: 5,
            );
          } else {
            _showMyDialog();
          }
        },
        child: Container(
          height: 85,
          width: MediaQuery.of(context).size.width / 1.2,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).secondaryHeaderColor,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                height: 60,
                width: 60,
                child: Image.asset(
                    'assets/images/${getRewardLevel(int.parse(widget.reward.points))}'),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              SizedBox(
                width: 14,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.reward.owner,
                  ),
                  Text(
                    widget.reward.product,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: getRewardColor(
                          int.parse(widget.reward.points),
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        widget.reward.points,
                      ),
                    ],
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
