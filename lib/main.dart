import 'package:flutter/material.dart';
import 'package:flutter_project/app/view/app.dart';
import 'package:flutter_project/app/app_initialize.dart';
import 'package:flutter_project/app/language/app_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitialize().make();
  runApp(AppLocalization(child: const MyApp()));
}
