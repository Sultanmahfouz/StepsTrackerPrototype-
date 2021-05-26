import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:steps_tracker_prototype/models/collection.dart';
import 'package:steps_tracker_prototype/models/reward.dart';

class RewardsService {

  
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

}