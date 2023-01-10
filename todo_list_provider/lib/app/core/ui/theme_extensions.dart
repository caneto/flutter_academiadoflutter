import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  Color get primaryColor => Theme.of(this).primaryColor; 
  Color get primaryColorLight => Theme.of(this).primaryColorLight; 
  // ignore: deprecated_member_use
  Color get buttonColor => Theme.of(this).buttonColor; 
  TextTheme get textTheme => Theme.of(this).textTheme;


  TextStyle get titleStyle => const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.grey
  );
}