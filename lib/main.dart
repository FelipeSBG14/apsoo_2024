import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import './src/app_module.dart';
import './src/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(
    ModularApp(
      module: AppModule(),
      child: AppWidget(),
    ),
  );
}
