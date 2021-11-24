import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

themes currenttheme = themes();

class themes with ChangeNotifier {
  static bool _isdarktheme = true;
  IconData themeicon = Icons.dark_mode_rounded;
  ThemeMode get currenttheme => _isdarktheme ? ThemeMode.dark : ThemeMode.light;

  ThemeData lighttheme = ThemeData.light();
  ThemeData darktheme = ThemeData.dark();

  void Onchangetheme() {
    _isdarktheme = !_isdarktheme;
    notifyListeners();
  }
}
