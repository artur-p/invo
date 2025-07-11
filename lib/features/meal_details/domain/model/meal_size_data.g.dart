// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_size_data.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MealSizeDataCWProxy {
  MealSizeData sizeType(SizeType sizeType);

  MealSizeData calories(int calories);

  MealSizeData proteins(int proteins);

  MealSizeData carbs(int carbs);

  MealSizeData fat(int fat);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MealSizeData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MealSizeData(...).copyWith(id: 12, name: "My name")
  /// ````
  MealSizeData call({
    SizeType sizeType,
    int calories,
    int proteins,
    int carbs,
    int fat,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMealSizeData.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMealSizeData.copyWith.fieldName(...)`
class _$MealSizeDataCWProxyImpl implements _$MealSizeDataCWProxy {
  const _$MealSizeDataCWProxyImpl(this._value);

  final MealSizeData _value;

  @override
  MealSizeData sizeType(SizeType sizeType) => this(sizeType: sizeType);

  @override
  MealSizeData calories(int calories) => this(calories: calories);

  @override
  MealSizeData proteins(int proteins) => this(proteins: proteins);

  @override
  MealSizeData carbs(int carbs) => this(carbs: carbs);

  @override
  MealSizeData fat(int fat) => this(fat: fat);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MealSizeData(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MealSizeData(...).copyWith(id: 12, name: "My name")
  /// ````
  MealSizeData call({
    Object? sizeType = const $CopyWithPlaceholder(),
    Object? calories = const $CopyWithPlaceholder(),
    Object? proteins = const $CopyWithPlaceholder(),
    Object? carbs = const $CopyWithPlaceholder(),
    Object? fat = const $CopyWithPlaceholder(),
  }) {
    return MealSizeData(
      sizeType: sizeType == const $CopyWithPlaceholder()
          ? _value.sizeType
          // ignore: cast_nullable_to_non_nullable
          : sizeType as SizeType,
      calories: calories == const $CopyWithPlaceholder()
          ? _value.calories
          // ignore: cast_nullable_to_non_nullable
          : calories as int,
      proteins: proteins == const $CopyWithPlaceholder()
          ? _value.proteins
          // ignore: cast_nullable_to_non_nullable
          : proteins as int,
      carbs: carbs == const $CopyWithPlaceholder()
          ? _value.carbs
          // ignore: cast_nullable_to_non_nullable
          : carbs as int,
      fat: fat == const $CopyWithPlaceholder()
          ? _value.fat
          // ignore: cast_nullable_to_non_nullable
          : fat as int,
    );
  }
}

extension $MealSizeDataCopyWith on MealSizeData {
  /// Returns a callable class that can be used as follows: `instanceOfMealSizeData.copyWith(...)` or like so:`instanceOfMealSizeData.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MealSizeDataCWProxy get copyWith => _$MealSizeDataCWProxyImpl(this);
}
