import 'package:invo_app/features/meal_details/data/model/meal_size_data_dto.dart';
import 'package:invo_app/features/meal_details/domain/model/meal_details.dart';
import 'package:json_annotation/json_annotation.dart';

part 'meal_details_dto.g.dart';

enum Allergens { wheat, gluten, milk }

@JsonSerializable()
class MealDetailsDto {
  const MealDetailsDto({
    required this.id,
    this.name,
    this.description,
    this.mealSizeData = const [],
    this.ingredients,
    this.allergens = const [],
  });

  factory MealDetailsDto.fromJson(Map<String, Object?> json) =>
      _$MealDetailsDtoFromJson(json);

  final int id;
  final String? name;
  final String? description;
  final List<MealSizeDataDto> mealSizeData;
  final String? ingredients;
  final List<Allergens> allergens;
}

extension ExamsDataDtoExt on MealDetailsDto {
  MealDetails toDomain() {
    return MealDetails(
      name: name,
      description: description,
      mealSizeData: mealSizeData.map((e) => e.toDomain()).toList(),
      ingredients: ingredients,
      allergens: allergens,
    );
  }
}
