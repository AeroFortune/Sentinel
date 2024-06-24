import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CustomShowcaseWidget extends StatelessWidget {
  const CustomShowcaseWidget({
    super.key,
    required this.globalKey,
    this.title,
    required this.description,
    required this.child,
    this.shapeBorder = const LinearBorder() });

  final GlobalKey globalKey;
  final String? title;
  final String description;
  final Widget child;
  final ShapeBorder shapeBorder;

  @override
  Widget build(BuildContext context) {
    return Showcase(
      showArrow: true,
      key: globalKey,
      title: title,
      targetPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
      titleAlignment: TextAlign.center,
      description: description,
      targetShapeBorder: shapeBorder,
      child: child,
    );
  }
}
