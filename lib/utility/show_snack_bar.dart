
import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      content: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      )));
}
