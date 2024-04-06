import 'package:flutter/material.dart';
import 'package:flutter_project/app/theme/base/app_color_scheme.dart';
import 'package:flutter_project/app/theme/base/base_app_theme.dart';
import 'package:flutter_project/resources/radius_manager.dart';
import 'package:flutter_project/resources/styles_manager.dart';

final class AppDarkTheme implements AppTheme {
  @override
  ThemeData get themeData => ThemeData(
      useMaterial3: true,
      colorScheme: AppColorScheme.darkColorScheme,
      brightness: Brightness.dark,
      textTheme: TTextTheme.darkTextTheme,
      textButtonTheme: textButtonThemeData,
      inputDecorationTheme: inputDecorationTheme);

  @override
  final TextButtonThemeData textButtonThemeData = TextButtonThemeData(
      style: TextButton.styleFrom(
    textStyle: TTextTheme.darkTextTheme.bodyLarge,
  ));

  @override
  final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusManager.small.value)),
  );
  

}
