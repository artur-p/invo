import 'package:invo_app/features/meal_details/data/model/meal_details_dto.dart';
import 'package:invo_app/features/meal_details/domain/model/meal_size_data.dart';

class MealDetails {
  const MealDetails({
    this.name,
    this.description,
    this.mealSizeData = const [],
    this.ingredients,
    this.allergens = const [],
  });

  final String? name;
  final String? description;
  final List<MealSizeData> mealSizeData;
  final String? ingredients;
  final List<Allergens> allergens;
}
