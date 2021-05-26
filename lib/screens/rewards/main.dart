import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/models/reward.dart';
import 'package:steps_tracker_prototype/screens/rewards/rewards.dart';

class MainReward extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rewards = Provider.of<List<Reward>>(context);
    return rewards != null
        ? rewards.length != 0
            ? Scaffold(
                body: Rewards(
                  allAvailableRewards: rewards,
                ),
              )
            : Scaffold(
                body: CircularProgressIndicator(),
              )
        : Scaffold(
            body: Container(
              color: Colors.green,
              child: Text('No rewards'),
            ),
          );
  }
}
