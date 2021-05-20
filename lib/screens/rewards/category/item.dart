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
          width: 92,
          decoration: BoxDecoration(
            color: isActive ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.orange : Colors.white,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
