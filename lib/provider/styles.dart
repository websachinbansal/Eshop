import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return isDarkTheme
        ? ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            )
        : ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            );
  }
}
