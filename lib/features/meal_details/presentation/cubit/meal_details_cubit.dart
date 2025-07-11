import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:invo_app/features/meal_details/domain/use_case/meal_details_use_case.dart';
import 'package:invo_app/utils/cubit/invo_cubit.dart';

import 'meal_details_state.dart';

@injectable
class MealDetailsCubit extends InvoCubit<MealDetailsState> {
  MealDetailsCubit(this._mealDetailsUseCase) : super(MealDetailsState());

  final MealDetailsUseCase _mealDetailsUseCase;

  Future<void> getMealDetails(int mealId) async {
    final mealDetail = await _mealDetailsUseCase.getMealDetails(mealId);

    emit(state.copyWith(status: MealDetailsLoadedStatus(mealDetail)));
  }
}
