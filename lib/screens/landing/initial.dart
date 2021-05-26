// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:steps_tracker_prototype/menu/main.dart';
// import 'package:steps_tracker_prototype/models/user.dart';
// import 'package:steps_tracker_prototype/screens/step/landing/landing.dart';

// // ignore: must_be_immutable
// class InitialLanding extends StatelessWidget {
//   List<bool> isHighlighted = [true, false, false, false, false, false];
//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserData>(context);
//     print(user.name ?? 'nothing');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Healthy'),
//         elevation: 0,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       ),
//       drawer: MainMenu(isHighlighted),
//       body: Landing(
//         user: user,
//       ),
//     );
//   }
// }
