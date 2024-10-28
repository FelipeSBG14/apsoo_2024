// ignore_for_file: unused_field

import 'package:flutter/material.dart';

class GlobalContext {
  late final GlobalKey<NavigatorState> _navigatorKey;

  static GlobalContext? _i;
  GlobalContext._();
  static GlobalContext get i {
    _i ??= GlobalContext._();
    return _i!;
  }

  set navigatoKey(GlobalKey<NavigatorState> key) => _navigatorKey = key;
}
