import 'package:flutter/material.dart';
import 'package:flutter_project/app/theme/base/app_color_scheme.dart';
import 'package:flutter_project/app/theme/base/base_app_theme.dart';
import 'package:flutter_project/resources/radius_manager.dart';
import 'package:flutter_project/resources/styles_manager.dart';

// Custom App Ligth Theme
final class AppLightTheme implements AppTheme {
  @override
  ThemeData get themeData => ThemeData(
      useMaterial3: true,
      colorScheme: AppColorScheme.lightColorScheme,
      textTheme: TTextTheme.lightTextTheme,
      brightness: Brightness.light,
      inputDecorationTheme: inputDecorationTheme,
      elevatedButtonTheme: elevatedButtonThemeData
      
      );

  @override
  final TextButtonThemeData textButtonThemeData = TextButtonThemeData(
      style: TextButton.styleFrom(
    textStyle: TTextTheme.lightTextTheme.bodyLarge,
  ));

  @override
  final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusManager.small.value)),
  );
  
  @override
  // TODO: implement elevatedButtonThemeData
  ElevatedButtonThemeData get elevatedButtonThemeData => ElevatedButtonThemeData(
   style: ElevatedButton.styleFrom(
    backgroundColor: Colors.amber,
    maximumSize: const Size(double.infinity, 50)
   ) 
  );


}
