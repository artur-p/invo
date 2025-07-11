// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/meal_details/data/repository/invo_meal_details_repository.dart'
    as _i552;
import '../../features/meal_details/domain/repository/meal_details_repository.dart'
    as _i174;
import '../../features/meal_details/domain/use_case/meal_details_use_case.dart'
    as _i453;
import '../../features/meal_details/presentation/cubit/meal_details_cubit.dart'
    as _i409;
import '../configs/base_configs.dart' as _i32;
import '../configs/dev_configs.dart' as _i920;

const String _dev = 'dev';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt $initGetIt({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i32.BaseConfigs>(() => _i920.DevConfigs(), registerFor: {_dev});
    gh.factory<_i174.IMealDetailsRepository>(
      () => _i552.InvoMealDetailsRepository(),
    );
    gh.factory<_i453.MealDetailsUseCase>(
      () => _i453.MealDetailsUseCase(gh<_i174.IMealDetailsRepository>()),
    );
    gh.factory<_i409.MealDetailsCubit>(
      () => _i409.MealDetailsCubit(gh<_i453.MealDetailsUseCase>()),
    );
    return this;
  }
}
