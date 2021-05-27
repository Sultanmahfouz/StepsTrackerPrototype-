import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/models/reward.dart';

// ignore: must_be_immutable
class CouponItemCard extends StatefulWidget {
  Reward coupon;
  CouponItemCard({this.coupon});

  @override
  _CouponItemCardState createState() => _CouponItemCardState();
}

class _CouponItemCardState extends State<CouponItemCard> {
  int points;

  @override
  // ignore: must_call_super
  void initState() {
    points = int.parse(widget.coupon.points ?? '0');
  }

  String getRewardLevel(int points) {
    if (points < 25) {
      return 'silver.jpeg';
    } else if (points < 70) {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Container(
        height: 85,
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
            Container(
              height: 60,
              width: 60,
              child: Image.asset(
                  'assets/images/${getRewardLevel(int.parse(widget.coupon.points))}'),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.coupon.owner,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  widget.coupon.product,
                ),
                Text(
                  widget.coupon.coupon,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
