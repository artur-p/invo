import 'package:flutter/material.dart';
import 'package:invo_app/app/foundations/colors/colors.dart';

class InvoInkWell extends StatelessWidget {
  const InvoInkWell({
    required this.child,
    super.key,
    this.disabled = false,
    this.onTap,
    this.borderRadius,
    this.backgroundColor,
  });

  final Widget child;
  final bool disabled;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final fillColor = disabled
        ? context.colors.disabled
        : backgroundColor ?? context.colors.transparent;

    final materialWidget = Material(
      color: fillColor,
      child: InkWell(
        onTap: disabled ? null : onTap,
        focusColor: fillColor,
        hoverColor: context.colors.background,
        highlightColor: context.colors.transparent,
        enableFeedback: false,
        canRequestFocus: false,
        splashColor: context.colors.splash,
        child: child,
      ),
    );

    return borderRadius != null
        ? ClipRRect(borderRadius: borderRadius!, child: materialWidget)
        : materialWidget;
  }
}
