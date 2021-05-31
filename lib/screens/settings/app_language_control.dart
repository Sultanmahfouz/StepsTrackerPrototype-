import 'package:flutter/material.dart';
import 'package:steps_tracker_prototype/components/constants.dart';

class ChangeAppLanguageButtonWidget extends StatefulWidget {
  @override
  _ChangeAppLanguageButtonWidgetState createState() =>
      _ChangeAppLanguageButtonWidgetState();
}

class _ChangeAppLanguageButtonWidgetState
    extends State<ChangeAppLanguageButtonWidget> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    return Switch.adaptive(
      value: status,
      onChanged: (value) {
        if (value) {
          setState(() {
            language = Locale('ar', 'SA');
            status = true;
          });
        } else {
          setState(() {
            language = Locale('en', 'US');
            status = false;
          });
        }
      },
      activeColor: Theme.of(context).scaffoldBackgroundColor,
      inactiveTrackColor: Colors.grey,
    );
  }
}
