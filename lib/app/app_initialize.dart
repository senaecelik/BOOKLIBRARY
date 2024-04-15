
import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/app/environment/index.dart';
import 'package:flutter_project/app/firebase_options.dart';
import 'package:flutter_project/app/utils/device_info/device_info.dart';
import 'package:flutter_project/app/utils/package_info/package_info.dart';
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


  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    // ... other providers
  ]);

    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableLevels = [LevelMessages.error];
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);


  AppEnvironment.setup(config: DevEnv());
  PackageInfoUtils.init();
  DeviceInfoUtils.init(); 



    FlutterError.onError =(details) {
      /// crashlytics log insert here
      /// custom service
      /// 
      /// TODO: Add custom logger
      Logger().e(details.exceptionAsString());
    };
  }
}
