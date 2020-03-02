import 'package:flutter/material.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class ThemeModel extends StatesRebuilder {
  Brightness brightness = Brightness.dark;
  Brightness brightnessStatus = Brightness.light;
  String sender = "Dark";
  String receiver = "Light";
  bool isDark = true;
  Color accentColor = Colors.pink;
  Color primaryColor = Colors.white;

  void changeBrightness() {
    brightness = isDark ? Brightness.light : Brightness.dark;
    isDark = brightness == Brightness.dark;
    brightnessStatus = isDark ? Brightness.light : Brightness.dark;
    sender = isDark ? "Dark" : "Light";
    receiver = isDark ? "Light" : "Dark";
    accentColor = isDark ? Colors.pink : Colors.red;
    primaryColor = isDark ? Colors.black : Colors.white;
    rebuildStates();
  }
}