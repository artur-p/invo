// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_details_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$MealDetailsStateCWProxy {
  MealDetailsState status(MealDetailsStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MealDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MealDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  MealDetailsState call({MealDetailsStatus status});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfMealDetailsState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfMealDetailsState.copyWith.fieldName(...)`
class _$MealDetailsStateCWProxyImpl implements _$MealDetailsStateCWProxy {
  const _$MealDetailsStateCWProxyImpl(this._value);

  final MealDetailsState _value;

  @override
  MealDetailsState status(MealDetailsStatus status) => this(status: status);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `MealDetailsState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// MealDetailsState(...).copyWith(id: 12, name: "My name")
  /// ````
  MealDetailsState call({Object? status = const $CopyWithPlaceholder()}) {
    return MealDetailsState(
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as MealDetailsStatus,
    );
  }
}

extension $MealDetailsStateCopyWith on MealDetailsState {
  /// Returns a callable class that can be used as follows: `instanceOfMealDetailsState.copyWith(...)` or like so:`instanceOfMealDetailsState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$MealDetailsStateCWProxy get copyWith => _$MealDetailsStateCWProxyImpl(this);
}
