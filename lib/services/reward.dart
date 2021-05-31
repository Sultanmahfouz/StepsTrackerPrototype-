import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/models/collection.dart';
import 'package:steps_tracker_prototype/models/reward.dart';

class RewardsService {
  List<Reward> currentRewards = [];

  List<Reward> _rewardsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Reward.fromMap(doc.data());
    }).toList();
  }

  Stream<List<Reward>> getAvailableRewards() {
    return FirebaseCollections()
        .rewards
        .where('available', isEqualTo: true)
        .snapshots()
        .map(_rewardsListFromSnapshot);
  }

  String getRewardLevel(int points) {
    if (points < 100) {
      return 'silver.jpeg';
    } else if (points < 200) {
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
}
