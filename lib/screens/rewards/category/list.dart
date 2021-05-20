import 'package:flutter/material.dart';
import 'item.dart';

// ignore: must_be_immutable
class CategoryListRewards extends StatefulWidget {
  String firstCategory;
  String secondCategory;
  String thirdCategory;
  String fourthCategory;
  Function callBack;

  CategoryListRewards(
      {this.firstCategory,
      this.secondCategory,
      this.thirdCategory,
      this.fourthCategory,
      this.callBack});

  @override
  _CategoryListRewardsState createState() => _CategoryListRewardsState();
}

class _CategoryListRewardsState extends State<CategoryListRewards> {
  List<String> categoryListRewards = [];
  String selectedCategory;

  @override
  void initState() {
    categoryListRewards.addAll([
      widget.firstCategory,
      widget.secondCategory,
      widget.thirdCategory,
      widget.fourthCategory,
    ]);

    selectedCategory = categoryListRewards.first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: EdgeInsets.only(left: 8.0),
        child: Row(
          children: List.generate(
            categoryListRewards.length,
            (index) => CategoryItemReward(
              title: categoryListRewards[index],
              isActive: categoryListRewards[index] == selectedCategory,
              onTap: () {
                selectedCategory = categoryListRewards[index];
                widget.callBack(selectedCategory);
                setState(() {});
              },
            ),
          ),
        ),
      ),
    );
  }
}
