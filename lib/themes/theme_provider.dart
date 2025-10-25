import 'package:flutter/material.dart';
import 'package:flutter_wall/themes/dark.dart';
import 'package:flutter_wall/themes/light.dart';


class ThemeProvider with ChangeNotifier{
  ThemeData _themeData= lightMode;

  ThemeData get themeData=> _themeData;

  bool get isDark=> _themeData==darkMode;

  set themeData(ThemeData themeData){
    _themeData= themeData;
    notifyListeners();
  }

  void toggleTheme(){
    _themeData=_themeData==lightMode? darkMode: lightMode;
    notifyListeners();
  }
}
