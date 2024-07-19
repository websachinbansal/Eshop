import 'package:shared_preferences/shared_preferences.dart';

class DarkThemePreferences {
  static const Theme_Status = 'ThemeStatus';

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(Theme_Status, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Theme_Status) ?? false;
  }
}
