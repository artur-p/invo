import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:invo_app/features/meal_details/domain/model/meal_details.dart';

part 'meal_details_state.g.dart';

@CopyWith()
final class MealDetailsState with EquatableMixin {
  const MealDetailsState({this.status = const MealDetailsLoadingStatus()});

  final MealDetailsStatus status;

  @override
  List<Object?> get props => [status];
}

sealed class MealDetailsStatus {
  const MealDetailsStatus();
}

final class MealDetailsLoadingStatus extends MealDetailsStatus {
  const MealDetailsLoadingStatus();
}

final class MealDetailsLoadedStatus extends MealDetailsStatus {
  const MealDetailsLoadedStatus(this.mealDetails);

  final MealDetails mealDetails;
}
