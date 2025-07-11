// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealDetailsDto _$MealDetailsDtoFromJson(Map<String, dynamic> json) =>
    MealDetailsDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      mealSizeData:
          (json['meal_size_data'] as List<dynamic>?)
              ?.map((e) => MealSizeDataDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      ingredients: json['ingredients'] as String?,
      allergens:
          (json['allergens'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$AllergensEnumMap, e))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MealDetailsDtoToJson(
  MealDetailsDto instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'meal_size_data': instance.mealSizeData,
  'ingredients': instance.ingredients,
  'allergens': instance.allergens.map((e) => _$AllergensEnumMap[e]!).toList(),
};

const _$AllergensEnumMap = {
  Allergens.wheat: 'wheat',
  Allergens.gluten: 'gluten',
  Allergens.milk: 'milk',
};
