import 'package:flutter/widgets.dart';

class ColorsApp {
  static ColorsApp? _instance;

  ColorsApp._();
  static ColorsApp get instance{
    _instance??= ColorsApp._();
    return _instance!;
  }

  Color get googleColor => const Color(0xFFE15031);
  Color get facebookColor => const Color(0xFF4267B3);
  
}

extension ColorsAppExtensions on BuildContext {
  ColorsApp get colors => ColorsApp.instance;
}
