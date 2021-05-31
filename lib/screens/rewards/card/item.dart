import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/components/messages.dart';
import 'package:steps_tracker_prototype/models/reward.dart';
import 'package:steps_tracker_prototype/services/reward.dart';

// ignore: must_be_immutable
class RewardItemCard extends StatefulWidget {
  Reward reward;
  RewardItemCard({this.reward});

  @override
  _RewardItemCardState createState() => _RewardItemCardState();
}

class _RewardItemCardState extends State<RewardItemCard> {
  int points;

  String cardLevel = '';
  Color rewardColor;

  @override
  // ignore: must_call_super
  void initState() {
    points = int.parse(widget.reward.points ?? '0');
  }

  @override
  Widget build(BuildContext context) {
    cardLevel = RewardsService().getRewardLevel(points);
    rewardColor = RewardsService().getRewardColor(points);

    return Padding(
      padding: EdgeInsets.all(8),
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
                  // getRewardLevel(int.parse(widget.reward.points))
                  'assets/images/$cardLevel'),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Expanded(
              child: Column(
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
                        color: rewardColor,
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
            ),
            GestureDetector(
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
                  DialogMessages()
                      .inabilityActionMessage(context, points, healthPoints);
                }
              },
              child: Container(
                child: Icon(
                  Icons.redeem,
                  size: 26,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: healthPoints > points
                      ? Colors.green[400]
                      : Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
