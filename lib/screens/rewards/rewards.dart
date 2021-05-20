import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/components/constants.dart';
import 'package:steps_tracker_prototype/models/reward.dart';
import 'card/list.dart';
import 'category/list.dart';

class Rewards extends StatefulWidget {
  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  List<Reward> allRewards = [
    Reward(
      id: '87463',
      owner: 'Jarir',
      points: 24,
      product: 'Digital Watches',
      priceOff: 177.99,
      category: 'Watches',
    ),
    Reward(
      id: '87',
      owner: 'Tokyo',
      points: 100,
      product: 'Video Games',
      priceOff: 99.99,
      category: 'Watches',
    ),
    Reward(
        id: '4322',
        owner: 'Zara',
        points: 80,
        product: 'Chammel',
        priceOff: 150,
        category: 'Watches'),
  ];

  String selectedCategory;

  List<Reward> currentRewards = [];

  void categoryListCallBack(String category) {
    currentRewards.clear();

    if (category == 'All Rewards') {
      currentRewards.addAll(allRewards);
    } else if (category == 'Watches') {
      currentRewards.addAll(
        allRewards.where((reward) => reward.category == 'Watches').toList(),
      );
    }

    setState(() {});
  }

  @override
  void initState() {
    currentRewards = allRewards ?? [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 6,
                  left: 30,
                ),
                child: Row(
                  children: [
                    Text(
                      'Rewards',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(
                      width: 200,
                    ),
                    Text(healthPoints.toString()),
                  ],
                ),
              ),
            ],
          ),
          // Search UI
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
    );
  }
}
