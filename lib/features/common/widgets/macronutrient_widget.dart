import 'package:flutter/material.dart';
import 'package:invo_app/app/foundations/colors/colors.dart';
import 'package:invo_app/app/foundations/spacing/spacing.dart';
import 'package:invo_app/app/foundations/styles/app_text_style.dart';

class MacronutrientsWidget extends StatelessWidget {
  const MacronutrientsWidget({
    super.key,
    required this.title,
    required this.description,
    required this.color,
  });

  final String title;
  final String description;
  final InvoColor color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.macronutrientBg,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsetsGeometry.all(InvoSpaces.space3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.only(
                top: InvoSpaces.space16,
                left: InvoSpaces.space8,
                right: InvoSpaces.space8,
                bottom: InvoSpaces.space24,
              ),
              child: Text(
                title,
                style: context.textStyles.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    color.withValues(alpha: 0.0),
                    color.withValues(alpha: 0.2),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  top: InvoSpaces.space24,
                  left: InvoSpaces.space8,
                  right: InvoSpaces.space8,
                  bottom: InvoSpaces.space8,
                ),
                child: Center(
                  child: Text(
                    description,
                    style: context.textStyles.textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
