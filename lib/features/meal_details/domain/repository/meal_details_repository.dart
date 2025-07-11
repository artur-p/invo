import 'package:invo_app/features/meal_details/domain/model/meal_details.dart';

abstract interface class IMealDetailsRepository {
  Future<MealDetails> getMealDetails(int mealId);
}
