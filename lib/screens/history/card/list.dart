import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/components/constants.dart';

import '../../../app_localization.dart';
import 'item.dart';

// ignore: must_be_immutable
class HistoryListCard extends StatefulWidget {
  @override
  _HistoryListCardState createState() => _HistoryListCardState();
}

class _HistoryListCardState extends State<HistoryListCard> {
  @override
  Widget build(BuildContext context) {
    if (userHistory.length != 0) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: List.generate(
            userHistory.length,
            (index) => HistoryItemCard(
              history: userHistory[index],
            ),
          ),
        ),
      );
    } else {
      return Center(
        child: Container(
          child: Text(
            AppLocalizations.of(context)
                .getTitle("massage_history_not_available"),
          ),
        ),
      );
    }
  }
}
