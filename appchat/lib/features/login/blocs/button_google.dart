import 'package:appchat/env/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ButtonGoogle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeModel theme = Injector.get(context: context);
    return Container(
      width: 100,
      height: 35,
      padding: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: theme.accentColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            Icons.tag_faces,
            size: 16,
            color: theme.primaryColor,
          ),
          Text(
            'Google',
            style: TextStyle(
              fontSize: 12,
              color: theme.primaryColor,
            ),
          )
        ],
      ),
    );
  }
}
