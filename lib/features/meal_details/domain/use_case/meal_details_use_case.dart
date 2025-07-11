import 'package:injectable/injectable.dart';
import 'package:invo_app/features/meal_details/domain/model/meal_details.dart';
import 'package:invo_app/features/meal_details/domain/repository/meal_details_repository.dart';

@Injectable()
final class MealDetailsUseCase {
  const MealDetailsUseCase(this._mealDetailsRepository);

  final IMealDetailsRepository _mealDetailsRepository;

  Future<MealDetails> getMealDetails(int mealId) =>
      _mealDetailsRepository.getMealDetails(mealId);
}
