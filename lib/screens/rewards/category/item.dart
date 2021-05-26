import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryItemReward extends StatelessWidget {
  String title;
  Function onTap;
  bool isActive;

  CategoryItemReward({this.title, this.onTap, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 30,
          width: 90,
          decoration: BoxDecoration(
            color: isActive ? Theme.of(context).primaryColor : null,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.black : Colors.white,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
