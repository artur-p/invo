import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:invo_app/features/meal_details/domain/model/meal_size_data.dart';

part 'meal_size_data_dto.g.dart';

enum SizeType { small, medium, large }

@JsonSerializable()
class MealSizeDataDto {
  const MealSizeDataDto({
    required this.id,
    this.sizeType,
    this.calories,
    this.proteins,
    this.carbs,
    this.fat,
  });

  factory MealSizeDataDto.fromJson(Map<String, Object?> json) =>
      _$MealSizeDataDtoFromJson(json);

  final int id;
  final SizeType? sizeType;
  final int? calories;
  final int? proteins;
  final int? carbs;
  final int? fat;
}

extension MealSizeDataExt on MealSizeDataDto {
  MealSizeData toDomain() {
    return MealSizeData(
      sizeType: sizeType ?? SizeType.small,
      calories: calories ?? 0,
      proteins: proteins ?? 0,
      carbs: carbs ?? 0,
      fat: fat ?? 0,
    );
  }
}
