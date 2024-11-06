import 'package:flutter/material.dart';
import 'package:trab_apsoo/src/core/ui/style/app_colors.dart';
import 'package:trab_apsoo/src/core/ui/style/app_style.dart';
import 'package:trab_apsoo/src/core/ui/style/text_styles.dart';

class ThemeConfig {
  ThemeConfig._();

  static final theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: ColorsApp.i.primary,
      primary: ColorsApp.i.secondary,
      secondary: ColorsApp.i.secondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppStyles.i.primaryButton,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyles.i.textRegular.copyWith(
        color: Colors.black, // Cor mais forte para o texto digitado
        fontSize: 18, // Tamanho de fonte maior para o texto digitado
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.transparent,
      filled: true,
      isDense: true,
      contentPadding: const EdgeInsets.all(20),
      labelStyle: TextStyles.i.textRegular.copyWith(color: Colors.grey),
      errorStyle: TextStyles.i.textRegular.copyWith(color: Colors.redAccent),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    ),
  );
}
