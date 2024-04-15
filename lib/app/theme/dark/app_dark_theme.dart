import 'package:flutter/material.dart';
import 'package:flutter_project/app/theme/base/app_color_scheme.dart';
import 'package:flutter_project/app/theme/base/base_app_theme.dart';
import 'package:flutter_project/core/client/resources/radius_manager.dart';
import 'package:flutter_project/core/client/resources/styles_manager.dart';

final class AppDarkTheme implements AppTheme {
  @override
  ThemeData get themeData => ThemeData(
      useMaterial3: true,
      colorScheme: AppColorScheme.darkColorScheme,
      brightness: Brightness.dark,
      textTheme: TTextTheme.darkTextTheme,
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
  
 // TODO: implement elevatedButtonThemeData
  ElevatedButtonThemeData get elevatedButtonThemeData => ElevatedButtonThemeData(
   style: ElevatedButton.styleFrom(
    maximumSize: Size(double.infinity, 50)
   ) 
  );
}
