import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/app_localization.dart';
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
  List<bool> isHighlighted = [false, false, false, false, true, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          AppLocalizations.of(context).getTitle("coupons_appBar"),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      drawer: MyDrawer(isHighlighted),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 8,
                  left: 30,
                  right: 30,
                ),
                child: Text(
                  userCoupons.length != 0
                      ? AppLocalizations.of(context)
                          .getTitle("available_coupons")
                      : ': (',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 23,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: CouponListCard(
                    allCoupons: userCoupons,
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
