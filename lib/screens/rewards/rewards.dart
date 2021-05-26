import 'dart:async';

import 'package:flutter/material.dart';
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
  List<bool> isHighlighted = [false, false, true, false, false, false];

  String currentCategory = 'All Rewards';
  String selectedCategory;
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
  void categoryListCallBack(String category) {
    currentRewards.clear();
    if (category == 'All Rewards') {
      currentRewards.addAll(widget.allAvailableRewards);
    } else if (category == 'Watches') {
      currentRewards = widget.allAvailableRewards
          .where((reward) => reward.category == 'Watches')
          .toList();
    } else if (category == 'Perfumes') {
      currentRewards = widget.allAvailableRewards
          .where((reward) => reward.category == 'Perfumes')
          .toList();
    } else if (category == 'Toys') {
      currentRewards = widget.allAvailableRewards
          .where((reward) => reward.category == 'Toys')
          .toList();
    }

    setState(() {});
  }

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
    Timer.periodic(Duration(seconds: 2), (timer) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Center(child: Text('Rewards')),
        actions: [
          // ChangeThemeButtonWidget(),
          Icon(
            Icons.run_circle,
          ),
          SizedBox(
            width: 5,
          ),
          Center(
            child: Text(
              healthPoints.toString(),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
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
                          'Special Rewards',
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
              CategoryListRewards(
                firstCategory: 'All Rewards',
                secondCategory: 'Watches',
                thirdCategory: 'Perfumes',
                fourthCategory: 'Toys',
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
}
