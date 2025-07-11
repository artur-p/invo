import 'package:invo_app/features/meal_details/data/model/meal_details_dto.dart';
import 'package:invo_app/features/meal_details/data/model/meal_size_data_dto.dart';
import 'package:invo_app/features/meal_details/domain/model/meal_details.dart';
import 'package:invo_app/features/meal_details/domain/model/meal_size_data.dart';

final testMeal = MealDetails(
  name: 'Kanapka z wege i szarpaną kaczką',
  description:
      'Odkryj nowy wymiar smaku z kanapką z wege szarpaną kaczką – idealnym połączeniem soczystej, roślinnej alternatywy i chrupiącego pieczywa. Każdy kęs to harmonia przypraw, świeżych dodatków i zaskakująco autentycznego smaku, który zachwyci nie tylko wegetarian.',
  mealSizeData: [
    MealSizeData(
      sizeType: SizeType.small,
      calories: 430,
      proteins: 45,
      carbs: 55,
      fat: 18,
    ),
    MealSizeData(
      sizeType: SizeType.large,
      calories: 607,
      proteins: 57,
      carbs: 68,
      fat: 27,
    ),
    MealSizeData(
      sizeType: SizeType.medium,
      calories: 832,
      proteins: 69,
      carbs: 85,
      fat: 35,
    ),
  ],
  ingredients:
      'Chrupiące pieczywo, wegańska szarpana kaczka, świeża sałata, ogórek, pomidor, sos barbecue wegański',
  allergens: Allergens.values,
);
