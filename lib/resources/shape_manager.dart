import 'package:flutter/material.dart';
import 'package:flutter_project/resources/radius_manager.dart';

class ShapeManager {
  ShapeManager._();
  static ButtonStyle primaryTheme = ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(RadiusManager.small.value)),
    minimumSize: const Size.fromHeight(50),
  );
}
