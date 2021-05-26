import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker_prototype/models/user.dart';
import 'package:steps_tracker_prototype/services/user.dart';

import 'drawer.dart';

// ignore: must_be_immutable
class MainMenu extends StatelessWidget {
  List<bool> isHighlighted;
  MainMenu(this.isHighlighted);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserData>.value(
      value:
          UserService().getUserDocument(FirebaseAuth.instance.currentUser?.uid),
      child: MyDrawer(isHighlighted),
    );
  }
}
