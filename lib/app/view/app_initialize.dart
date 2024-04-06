import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/app/environment/index.dart';
import 'package:flutter_project/firebase_options.dart';
import 'package:logger/logger.dart';

@immutable

/// This class is used to initialize the application process
final class AppInitialize {


/// Project basic required initialize
  Future<void> make() async{
  await  runZonedGuarded<Future<void>>(_initialize, (error, stack) { 
      Logger().e(error);
    });
  }

  /// This method is used to initialize the application process
  static Future<void> _initialize() async {

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableLevels = [LevelMessages.error];
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


  AppEnvironment.setup(config: DevEnv());



    FlutterError.onError =(details) {
      /// crashlytics log insert here
      /// custom service
      /// 
      /// TODO: Add custom logger
      Logger().e(details.exceptionAsString());
    };
  }
}
