import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/models/user.dart';

// ignore: must_be_immutable
class RankingItemCard extends StatefulWidget {
  int index;
  UserData user;
  RankingItemCard({this.user, this.index});

  @override
  _RankingItemCardState createState() => _RankingItemCardState();
}

class _RankingItemCardState extends State<RankingItemCard> {
  int userRanking;

  @override
  void initState() {
    userRanking = widget.index + 1;
    super.initState();
  }

  Color circleColor(int index) {
    if (index == 0) {
      return Color(0xFFFFD700);
    } else if (index == 1) {
      return Color(0xFFC0C0C0);
    } else if (index == 2) {
      return Color(0xFFCD7F32);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.index);
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Container(
          height: 75,
          width: MediaQuery.of(context).size.width / 1.2,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
              Text(
                userRanking.toString(),
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Divider(
                height: 30,
                thickness: 10,
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: isAnon
                    ? AssetImage('assets/images/anonymous.png')
                    : widget.user?.avatar == null || widget.user?.avatar == ''
                        ? AssetImage('assets/images/anonymous.png')
                        : NetworkImage(widget.user?.avatar),
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
                      widget.user.name,
                    ),
                    Text(
                      widget.user.footSteps.toString(),
                    ),
                  ],
                ),
              ),
              Container(
                child: Icon(
                  Icons.circle,
                  color: circleColor(widget.index) ??
                      Theme.of(context).secondaryHeaderColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
