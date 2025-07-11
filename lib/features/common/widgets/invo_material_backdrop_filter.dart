import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:invo_app/app/foundations/colors/colors.dart';

class InvoMaterialBackgroundFilter extends StatelessWidget {
  const InvoMaterialBackgroundFilter({
    required this.blur,
    this.containerColor,
    required this.child,
    this.decoration,
    this.borderRadius,
    this.containerHeight,
    this.containerPadding,
    super.key,
  });

  final EdgeInsetsGeometry? containerPadding;
  final double blur;
  final Color? containerColor;
  final double? containerHeight;
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,

      child: Material(
        shadowColor: context.colors.background,
        color: Colors.transparent,
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            width: double.maxFinite,
            color: containerColor,
            padding: containerPadding,
            height: containerHeight,
            child: child,
          ),
        ),
      ),
    );
  }
}
