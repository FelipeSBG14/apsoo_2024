import 'package:flutter/material.dart';

class ColorsApp {
  static ColorsApp? _i;
  ColorsApp._();
  static ColorsApp get i {
    _i ??= ColorsApp._();
    return _i!;
  }

  Color get primary => const Color(0xFFF5F5F5);
  Color get secondary => Colors.black;
}

extension ColorsAppExceptions on BuildContext {
  ColorsApp get colors => ColorsApp.i;
}
