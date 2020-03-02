import 'package:appchat/env/theme_model.dart';
import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ButtonLogin extends StatelessWidget {
  ButtonLogin({this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    final ThemeModel theme = Injector.get(context: context);
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: 180,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: theme.accentColor
      ),
      child: Center(
        child: Text(
          this.text,
          style: TextStyle(
              color: theme.primaryColor,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
