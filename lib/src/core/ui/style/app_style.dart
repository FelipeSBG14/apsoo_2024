import 'package:flutter/material.dart';
import 'package:trab_apsoo/src/core/ui/style/app_colors.dart';
import 'text_styles.dart';

class AppStyles {
  static AppStyles? _i;

  AppStyles._();
  static AppStyles get i {
    _i ??= AppStyles._();
    return _i!;
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        backgroundColor: ColorsApp.i.primary,
        textStyle: TextStyles.i.textButtonLabel,
        //textStyle:
      );
}

extension AppStylesExtension on BuildContext {
  AppStyles get appStyles => AppStyles.i;
}
