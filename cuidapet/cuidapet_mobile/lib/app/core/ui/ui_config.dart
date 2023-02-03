import 'package:flutter/material.dart';

class UiConfig {
  UiConfig._();

  static String get title => 'CuidaPet Module';
  static ThemeData get theme => ThemeData(
        primaryColor: const Color(0xffA8CE4B),
        primaryColorDark: const Color(0xff689F38),
        primaryColorLight: const Color(0xffDDE9C7),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xffA8CE4B),
        ),
      );
}
