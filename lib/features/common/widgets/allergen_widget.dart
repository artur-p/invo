import 'package:flutter/cupertino.dart';
import 'package:invo_app/app/foundations/spacing/spacing.dart';
import 'package:invo_app/app/foundations/styles/app_text_style.dart';
import 'package:invo_app/constants/assets.gen.dart';
import 'package:invo_app/features/meal_details/data/model/meal_details_dto.dart';
import 'package:invo_app/l10n/l10n.dart';

class AllergenWidget extends StatelessWidget {
  const AllergenWidget({
    super.key,
    required this.allergens,
    required this.isLast,
  });

  final Allergens allergens;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final String name;
    final SvgGenImage icon;

    switch (allergens) {
      case Allergens.wheat:
        name = context.loc.wheat;
        icon = Assets.icons.icWheat;
        break;
      case Allergens.gluten:
        name = context.loc.gluten;
        icon = Assets.icons.icGluten;
      case Allergens.milk:
        name = context.loc.milk;
        icon = Assets.icons.icMilk;
    }

    return Row(
      spacing: InvoSpaces.space4,
      mainAxisSize: MainAxisSize.min,
      children: [
        icon.svg(),
        Text(
          isLast ? name : '$name,',
          style: context.textStyles.textTheme.titleSmall,
        ),
      ],
    );
  }
}
