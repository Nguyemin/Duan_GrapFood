import 'package:flutter/material.dart';
import 'package:shop_lap_top/setting/dark_model.dart';
import 'package:shop_lap_top/setting/light_mode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themData (ThemeData themData){
    _themeData = themData;
    notifyListeners();
  }
  void toggleTheme(){
    if (_themeData == lightMode){
      themData = darkMode;
    } else{
      themData =lightMode;
    }
  }
}