import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:steps_tracker_prototype/app_localization.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/menu/drawer.dart';
import 'package:steps_tracker_prototype/models/reward.dart';
import 'card/list.dart';
import 'category/list.dart';

// ignore: must_be_immutable
class Rewards extends StatefulWidget {
  static final id = 'rewards_screen';
  List<Reward> allAvailableRewards;
  Rewards({this.allAvailableRewards});

  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  List<bool> isHighlighted = [false, false, true, false, false, false, false];

  String currentCategory = 'All';
  String selectedCategory;
  // dummy list
  List<Reward> allRewards = [
    Reward(
      id: '87463',
      owner: 'Jarir',
      product: 'Digital Watches',
      category: 'Perfume',
    ),
    Reward(
      id: '87',
      owner: 'Tokyo',
      product: 'Video Games',
      category: 'Watches',
    ),
    Reward(
      id: '4322',
      owner: 'Zara',
      product: 'Chammel',
      category: 'Watches',
    ),
    Reward(
      id: '4322',
      owner: 'Zara',
      product: 'Chammel',
      category: 'Perfumes',
    ),
  ];
  List<Reward> currentRewards = [];

  @override
  void initState() {
    if (widget.allAvailableRewards == null) {
      widget.allAvailableRewards = [];
    }

    currentRewards = widget.allAvailableRewards?.toList() ?? [];
    showHealthPoints();

    super.initState();
  }

  Future<void> showHealthPoints() async {
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          AppLocalizations.of(context).getTitle("rewards_appBar"),
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      drawer: MyDrawer(isHighlighted),
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30.0, bottom: 30),
                child: Center(
                  child: CircularPercentIndicator(
                    animateFromLastPercent: true,
                    center: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)
                              .getTitle("Health_points"),
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          healthPoints.toString() +
                              '  /' +
                              AppLocalizations.of(context).getTitle("1000"),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.grey[500],
                    radius: 200.0,
                    progressColor: Theme.of(context).primaryColor,
                    percent: (1 / 1000.0) * healthPoints,
                    animation: true,
                    lineWidth: 14,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 30,
                  right: 30,
                ),
                child: Text(
                  AppLocalizations.of(context).getTitle("special_rewards"),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 23,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CategoryListRewards(
                firstCategory: AppLocalizations.of(context).getTitle("All"),
                secondCategory:
                    AppLocalizations.of(context).getTitle("Watches"),
                thirdCategory: AppLocalizations.of(context).getTitle("Tech"),
                fourthCategory: AppLocalizations.of(context).getTitle("Toys"),
                fifthCategory:
                    AppLocalizations.of(context).getTitle("Perfumes"),
                sixthCategory: AppLocalizations.of(context).getTitle("Bags"),
                callBack: categoryListCallBack,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Center(
                  child: RewardListCard(
                    allRewards: currentRewards,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void categoryListCallBack(String category) {
    currentRewards.clear();
    if (category == 'All' || category == 'الكل') {
      currentRewards.addAll(widget.allAvailableRewards);
    } else if (category == 'Watches' || category == "الساعات") {
      currentRewards = widget.allAvailableRewards
          .where((reward) => reward.category == 'Watches')
          .toList();
    } else if (category == 'Perfumes' || category == "عطور") {
      currentRewards = widget.allAvailableRewards
          .where((reward) => reward.category == 'Perfumes')
          .toList();
    } else if (category == 'Toys' || category == "العاب") {
      currentRewards = widget.allAvailableRewards
          .where((reward) => reward.category == 'Toys')
          .toList();
    } else if (category == 'Tech' || category == "تكنولوجيا") {
      currentRewards = widget.allAvailableRewards
          .where((reward) => reward.category == 'Tech')
          .toList();
    } else if (category == 'Bags' || category == "حقائب") {
      currentRewards = widget.allAvailableRewards
          .where((reward) => reward.category == 'Bags')
          .toList();
    }

    setState(() {});
  }
}
