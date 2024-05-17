import 'package:flutter/material.dart';
import 'package:flutter_project/resources/font_manager.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.left,
      title,
      style: Theme.of(context)
          .textTheme
          .headlineMedium!
          .copyWith(fontWeight: FontWeightManager.bold),
    );
  }
}
