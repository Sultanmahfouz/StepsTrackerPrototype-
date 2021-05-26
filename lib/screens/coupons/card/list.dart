import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/models/reward.dart';

import 'item.dart';

// ignore: must_be_immutable
class CouponListCard extends StatefulWidget {
  List<Reward> allCoupons;

  CouponListCard({this.allCoupons});

  @override
  _CouponListCardState createState() => _CouponListCardState();
}

class _CouponListCardState extends State<CouponListCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.allCoupons != null) {
      if (widget.allCoupons.length != 0) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: List.generate(
              widget.allCoupons.length,
              (index) => CouponItemCard(
                coupon: widget.allCoupons[index],
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
