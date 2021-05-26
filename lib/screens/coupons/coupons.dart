import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/menu/drawer.dart';

import 'card/list.dart';

// ignore: must_be_immutable
class Coupons extends StatefulWidget {
  static final id = 'coupons_screen';

  @override
  _CouponsState createState() => _CouponsState();
}

class _CouponsState extends State<Coupons> {
  List<bool> isHighlighted = [false, false, false, false, true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('Coupons'),
      ),
      drawer: MyDrawer(isHighlighted),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 8,
                      left: 30,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'My Rewards',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 23,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: CouponListCard(
                    allRewards: myRewards,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
