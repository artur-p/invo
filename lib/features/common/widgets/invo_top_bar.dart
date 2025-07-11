import 'package:flutter/cupertino.dart';
import 'package:invo_app/app/foundations/colors/colors.dart';
import 'package:invo_app/app/foundations/spacing/spacing.dart';
import 'package:invo_app/app/foundations/styles/app_text_style.dart';
import 'package:invo_app/constants/assets.gen.dart';
import 'package:invo_app/features/common/widgets/invo_ink_well.dart';
import 'package:invo_app/features/common/widgets/invo_material_backdrop_filter.dart';
import 'package:invo_app/l10n/l10n.dart';

class InvoTopBar extends StatelessWidget {
  const InvoTopBar({required this.onBackTap, super.key});

  final VoidCallback onBackTap;
  @override
  Widget build(BuildContext context) {
    return InvoMaterialBackgroundFilter(
      blur: 8,
      containerPadding: EdgeInsetsGeometry.only(
        top: InvoSpaces.space56,
        left: InvoSpaces.space12,
        right: InvoSpaces.space12,
      ),
      decoration: BoxDecoration(
        backgroundBlendMode: BlendMode.multiply,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            context.colors.dark.withValues(alpha: 0),
            context.colors.dark.withValues(alpha: 0.25),
          ],
          stops: [
            0.0,
            1.0,
          ], // You can omit this if you're fine with default spacing
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InvoInkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: onBackTap,
            child: Padding(
              padding: EdgeInsets.all(InvoSpaces.space10),
              child: Assets.icons.icArrowLeft.svg(),
            ),
          ),
          Expanded(
            child: Text(
              context.loc.mealDetails,
              textAlign: TextAlign.center,
              style: context.textStyles.textTheme.labelMedium?.copyWith(
                color: context.colors.textColor3,
              ),
            ),
          ),
          SizedBox(width: InvoSpaces.space32),
        ],
      ),
    );
  }
}
