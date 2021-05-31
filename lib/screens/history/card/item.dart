import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:steps_tracker_prototype/models/history.dart';

// ignore: must_be_immutable
class HistoryItemCard extends StatefulWidget {
  History history;
  HistoryItemCard({this.history});

  @override
  _HistoryItemCardState createState() => _HistoryItemCardState();
}

class _HistoryItemCardState extends State<HistoryItemCard> {
  String message;
  String owner;

  @override
  void initState() {
    owner = widget.history.owner;
    if (widget.history.kind == 'redeem') {
      message =
          '-${widget.history.points} health points spent on ${widget.history.owner.length < 12 ? widget.history.owner : widget.history.owner.substring(0, 12)} on ${DateFormat('d MMM, h a').format(widget.history.exchangeDate)}';
    } else {
      message =
          '+${widget.history.points} health points on ${DateFormat('d MMM, h a').format(widget.history.exchangeDate)}';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width / 1.1,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          borderRadius: BorderRadius.circular(20),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.history.owner ?? '',
                ),
                Container(
                  width: 300,
                  height: 40,
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: widget.history.kind == 'redeem'
                          ? Colors.redAccent
                          : Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
