import 'package:flutter/material.dart';
import 'package:flutter_project/core/client/resources/shape_manager.dart';

class OutlinedPrimaryButton extends StatelessWidget {
  const OutlinedPrimaryButton({
    super.key,
    required this.child,
    required this.onPressed, this.icon,
  });

  final Widget child;
  final void Function() onPressed;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ShapeManager.primaryTheme, onPressed: onPressed, child: child);
  }
}
