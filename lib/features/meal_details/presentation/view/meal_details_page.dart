import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:invo_app/app/foundations/colors/colors.dart';
import 'package:invo_app/app/foundations/spacing/spacing.dart';
import 'package:invo_app/app/foundations/styles/app_text_style.dart';
import 'package:invo_app/features/common/widgets/allergen_widget.dart';
import 'package:invo_app/features/common/widgets/invo_choice_chip.dart';
import 'package:invo_app/features/common/widgets/invo_loader.dart';
import 'package:invo_app/features/common/widgets/macronutrient_widget.dart';
import 'package:invo_app/features/common/widgets/slivers_top_card_page.dart';
import 'package:invo_app/features/common/widgets/small_header.dart';
import 'package:invo_app/features/meal_details/data/model/meal_size_data_dto.dart';
import 'package:invo_app/features/meal_details/presentation/cubit/meal_details_cubit.dart';
import 'package:invo_app/features/meal_details/presentation/cubit/meal_details_state.dart';
import 'package:invo_app/l10n/l10n.dart';
import 'package:invo_app/utils/hooks/use_cubit.dart';

class MealDetailsPage extends HookWidget {
  const MealDetailsPage({required this.mealId, super.key});

  final int mealId;

  @override
  Widget build(BuildContext context) {
    final cubit = useCubit(
      () => GetIt.I<MealDetailsCubit>()..getMealDetails(mealId),
    );

    return BlocBuilder<MealDetailsCubit, MealDetailsState>(
      bloc: cubit,
      builder: (context, state) {
        switch (state.status) {
          case MealDetailsLoadingStatus():
            return InvoLoader();
          case MealDetailsLoadedStatus():
            final details =
                (state.status as MealDetailsLoadedStatus).mealDetails;
            return SliversTopCardPage(
              title: details.name ?? context.loc.noData,
              onPopPage: () {
                ///TODO(Artur): add handle
              },
              smallImage: true,
              itemBuilder: (context) {
                return [
                  SliverLayoutBuilder(
                    builder: (context, constraints) {
                      return SliverList(
                        delegate: SliverChildListDelegate([
                          Padding(
                            padding: EdgeInsetsGeometry.all(InvoSpaces.space12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                InvoSpace.v12(),
                                Text(
                                  details.description ?? context.loc.noData,
                                  style: context
                                      .textStyles
                                      .textTheme
                                      .headlineMedium,
                                ),
                                InvoSpace.v32(),
                                HookBuilder(
                                  builder: (context) {
                                    final selectedValue = useState(0);

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        InvoChoiceChip<int>(
                                          items: details.mealSizeData
                                              .mapIndexed((index, e) {
                                                final label =
                                                    switch (e.sizeType) {
                                                      SizeType.small =>
                                                        context.loc.sizeS,
                                                      SizeType.medium =>
                                                        context.loc.sizeM,
                                                      SizeType.large =>
                                                        context.loc.sizeL,
                                                    };

                                                return ChoiceChipData(
                                                  label: label,
                                                  value: index,
                                                );
                                              })
                                              .toList(),
                                          onChanged: (value) {
                                            selectedValue.value = value;
                                          },
                                          initialValue: selectedValue.value,
                                        ),
                                        InvoSpace.v16(),
                                        IntrinsicWidth(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            spacing: InvoSpaces.space8,
                                            children: [
                                              MacronutrientsWidget(
                                                title: context.loc.calories,
                                                description:
                                                    '${details.mealSizeData[selectedValue.value].calories} kcal',
                                                color: context.colors.gradient2,
                                              ),
                                              MacronutrientsWidget(
                                                title: context.loc.proteins,
                                                description:
                                                    '${details.mealSizeData[selectedValue.value].proteins} g',
                                                color: context.colors.gradient3,
                                              ),
                                              MacronutrientsWidget(
                                                title: context.loc.carbs,
                                                description:
                                                    '${details.mealSizeData[selectedValue.value].carbs} g',
                                                color: context.colors.gradient4,
                                              ),
                                              MacronutrientsWidget(
                                                title: context.loc.fat,
                                                description:
                                                    '${details.mealSizeData[0].fat} g',
                                                color: context.colors.gradient5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                InvoSpace.v32(),
                                SmallHeader(context.loc.ingredients),
                                InvoSpace.v8(),
                                Text(
                                  details.ingredients ?? context.loc.noData,
                                  style:
                                      context.textStyles.textTheme.labelLarge,
                                ),
                                InvoSpace.v32(),
                                SmallHeader(context.loc.allergens),
                                InvoSpace.v12(),
                                Wrap(
                                  spacing: InvoSpaces.space8,
                                  children: details.allergens
                                      .mapIndexed(
                                        (index, e) => AllergenWidget(
                                          allergens: e,
                                          isLast:
                                              index ==
                                              details.allergens.length - 1,
                                        ),
                                      )
                                      .toList(),
                                ),
                                InvoSpace.v24(),
                              ],
                            ),
                          ),
                        ]),
                      );
                    },
                  ),
                ];
              },
            );
        }
      },
    );
  }
}
