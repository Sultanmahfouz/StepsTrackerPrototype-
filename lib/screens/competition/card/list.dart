import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/models/user.dart';

import 'item.dart';

// ignore: must_be_immutable
class RankingListCard extends StatefulWidget {
  List<UserData> allUsers;
  RankingListCard({this.allUsers});

  @override
  _RankingListCardState createState() => _RankingListCardState();
}

class _RankingListCardState extends State<RankingListCard> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: List.generate(
          widget.allUsers.length,
          (index) => RankingItemCard(
            user: widget.allUsers[index],
            index: index,
          ),
        ),
      ),
    );
  }
}
