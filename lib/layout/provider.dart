import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  bool isDark = false;
  changeDarkMode({bool fromShared}) {
    if (fromShared != null) {
      fromShared ? isDark = true : isDark = false;
      setThemeMode();
      notifyListeners();
    } else {
      isDark = false;
      setThemeMode();
      notifyListeners();
    }
  }

  changeCurrentMode() {
    isDark = !isDark;
    setThemeMode();
    notifyListeners();
  }

  Future setThemeMode() async {
    final pref = await SharedPreferences.getInstance();
    await pref.clear().then((value) async {
      await pref.setBool('isDark', isDark).then((value) async {});
    });
  }
}
