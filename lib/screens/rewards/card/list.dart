import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/models/reward.dart';

import 'item.dart';

// ignore: must_be_immutable
class RewardListCard extends StatefulWidget {
  List<Reward> allRewards;

  RewardListCard({this.allRewards});

  @override
  _RewardListCardState createState() => _RewardListCardState();
}

class _RewardListCardState extends State<RewardListCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.allRewards != null) {
      if (widget.allRewards.length != 0) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: List.generate(
              widget.allRewards.length,
              (index) => RewardItemCard(
                reward: widget.allRewards[index],
              ),
            ),
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.all(10),
          child: Text('Unfortunately, no rewards availabe at the moment :)'),
        );
      }
    } else {
      return Container(
        padding: EdgeInsets.all(10),
        child: Text('Unfortunately, no rewards availabe at the moment :)'),
      );
    }
  }
}
