import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  Color get primaryColorLight => Theme.of(this).primaryColorLight;
  Color get primaryColor => Theme.of(this).primaryColor;
  Color get buttonColor => Theme.of(this).buttonTheme.colorScheme!.background;
  TextTheme get textTheme => Theme.of(this).textTheme;

  TextStyle get titleStyle =>
      const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey,);
}
