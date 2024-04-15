// ignore_for_file: overridden_fields

import 'package:flutter/material.dart';
import 'package:flutter_project/core/client/resources/shape_manager.dart';
import 'package:flutter_project/core/widget/button/outlined_primary_button.dart';

final class OutlinedIconPrimaryButton extends OutlinedPrimaryButton {
  const OutlinedIconPrimaryButton({
    super.key,
    required super.child,
    required super.onPressed,
    required this.icon,
  });

  
  @override
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: ShapeManager.primaryTheme,
      onPressed: onPressed,
      icon: icon,
      label: child,
    );
  }
}
