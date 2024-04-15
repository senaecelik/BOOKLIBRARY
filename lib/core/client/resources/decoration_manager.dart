import 'package:flutter/material.dart';
import 'package:flutter_project/core/client/resources/radius_manager.dart';

class DecorationManager {
  DecorationManager._();
  static InputDecoration inputEmailDecoration = InputDecoration(
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusManager.small.value)),
  );

  static InputDecoration inputPasswordDecoration = InputDecoration(
    suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.visibility_off)),
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(RadiusManager.small.value)),
  );
}
