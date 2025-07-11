import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:invo_app/features/meal_details/domain/repository/meal_details_repository.dart';
import 'package:invo_app/features/meal_details/domain/use_case/meal_details_use_case.dart';
import 'package:invo_app/features/meal_details/presentation/cubit/meal_details_cubit.dart';
import 'package:invo_app/features/meal_details/presentation/view/meal_details_page.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/configure_golden_tests.dart';
import '../../utils/widget_tester_extension.dart';
import 'meal_details_data.dart';
import 'meal_details_golden_configs.dart';

void main() {
  group('MealDetailsPageTest', () {
    late MealDetailsCubit mealDetailsCubit;
    late IMealDetailsRepository mockedMealDetailsRepository;
    late MealDetailsUseCase mealDetailsUseCase;

    setUpAll(() async {
      GetIt.instance.registerFactory<MealDetailsCubit>(() => mealDetailsCubit);
    });

    setUp(() async {
      await configureGoldenTests();

      mockedMealDetailsRepository = _MockMealDetailsRepository();

      mealDetailsUseCase = MealDetailsUseCase(mockedMealDetailsRepository);

      mealDetailsCubit = MealDetailsCubit(mealDetailsUseCase);

      when(
        () => mockedMealDetailsRepository.getMealDetails(1),
      ).thenAnswer((_) async => Future.value(testMeal));
    });

    mealDetailsGoldenPageTest(
      0,
      testSteps: (tester) async => [
        await tester.pumpPage(
          widget: const MealDetailsPage(mealId: 1),
          name: '',
        ),
      ],
    );
  });
}

class _MockMealDetailsRepository extends Mock
    implements IMealDetailsRepository {}
