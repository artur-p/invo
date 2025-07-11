import 'package:flutter/material.dart';
import 'package:invo_app/app/foundations/colors/colors.dart';
import 'package:invo_app/app/foundations/spacing/spacing.dart';
import 'package:invo_app/app/foundations/styles/app_text_style.dart';
import 'package:invo_app/features/common/widgets/invo_ink_well.dart';

class ChoiceChipData<T> {
  const ChoiceChipData({required this.label, required this.value});

  final T value;
  final String label;
}

class InvoChoiceChip<T> extends StatelessWidget {
  const InvoChoiceChip({
    required this.items,
    required this.initialValue,
    required this.onChanged,
    super.key,
  });

  final List<ChoiceChipData<T>> items;
  final T? initialValue;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      begin: Alignment(-0.87, -0.49),
      end: Alignment(0.87, 0.49),
      colors: [
        context.colors.choiceChipGradient1,
        context.colors.choiceChipGradient2,
        context.colors.choiceChipGradient3,
        context.colors.choiceChipGradient4,
        context.colors.choiceChipGradient5,
      ],
      stops: [0, 0.2548, 0.5048, 0.75, 1],
    );

    final borderRadius = BorderRadius.circular(444);

    return Wrap(
      spacing: InvoSpaces.space8,
      children: items.map((chipData) {
        final selected = chipData.value == initialValue;

        return InvoInkWell(
          backgroundColor: context.colors.transparent,
          borderRadius: borderRadius,
          onTap: () => onChanged(chipData.value),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 100),
            decoration: BoxDecoration(
              gradient: selected ? gradient : null,
              color: selected ? null : Colors.transparent,
              borderRadius: borderRadius,
              border: Border.all(
                color: selected
                    ? Colors.transparent
                    : context.colors.choiceChipBorder,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsGeometry.symmetric(
                vertical: InvoSpaces.space8,
                horizontal: InvoSpaces.space12,
              ),
              child: Text(
                chipData.label,
                style: context.textStyles.textTheme.titleSmall?.copyWith(
                  color: selected
                      ? context.colors.textColor3
                      : context.colors.textColor1,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
