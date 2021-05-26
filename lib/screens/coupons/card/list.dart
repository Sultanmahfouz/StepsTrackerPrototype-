import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/models/reward.dart';

import 'item.dart';

// ignore: must_be_immutable
class CouponListCard extends StatefulWidget {
  List<Reward> allRewards;

  CouponListCard({this.allRewards});

  @override
  _CouponListCardState createState() => _CouponListCardState();
}

class _CouponListCardState extends State<CouponListCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.allRewards != null) {
      if (widget.allRewards.length != 0) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: List.generate(
              widget.allRewards.length,
              (index) => CouponItemCard(
                reward: widget.allRewards[index],
              ),
            ),
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.all(10),
          child: Text('Unfortunatel, no rewards availabe at the moment :)'),
        );
      }
    } else {
      return Container(
        padding: EdgeInsets.all(10),
        child: Text('Unfortunatel, no rewards availabe at the moment :)'),
      );
    }
  }
}
