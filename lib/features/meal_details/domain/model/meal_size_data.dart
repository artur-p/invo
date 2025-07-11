import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:invo_app/features/meal_details/data/model/meal_size_data_dto.dart';

part 'meal_size_data.g.dart';

@CopyWith()
class MealSizeData with EquatableMixin {
  const MealSizeData({
    required this.sizeType,
    required this.calories,
    required this.proteins,
    required this.carbs,
    required this.fat,
  });

  final SizeType sizeType;
  final int calories;
  final int proteins;
  final int carbs;
  final int fat;

  @override
  List<Object> get props => [sizeType, calories, proteins, carbs, fat];
}
