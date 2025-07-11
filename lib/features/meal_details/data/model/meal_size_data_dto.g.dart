// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_size_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealSizeDataDto _$MealSizeDataDtoFromJson(Map<String, dynamic> json) =>
    MealSizeDataDto(
      id: (json['id'] as num).toInt(),
      sizeType: $enumDecodeNullable(_$SizeTypeEnumMap, json['size_type']),
      calories: (json['calories'] as num?)?.toInt(),
      proteins: (json['proteins'] as num?)?.toInt(),
      carbs: (json['carbs'] as num?)?.toInt(),
      fat: (json['fat'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MealSizeDataDtoToJson(MealSizeDataDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'size_type': _$SizeTypeEnumMap[instance.sizeType],
      'calories': instance.calories,
      'proteins': instance.proteins,
      'carbs': instance.carbs,
      'fat': instance.fat,
    };

const _$SizeTypeEnumMap = {
  SizeType.small: 'small',
  SizeType.medium: 'medium',
  SizeType.large: 'large',
};
