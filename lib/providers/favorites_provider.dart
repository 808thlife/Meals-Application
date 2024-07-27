import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoritesNotifier extends StateNotifier<List<Meal>> {
  FavoritesNotifier() : super([]); // initial data.

  bool toggleMealFav(Meal meal) {
    final isFavorite = state.contains(meal);

    if (isFavorite) {
      // basically removing meal.
      state = state.where((itMeal) => itMeal.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoritesNotifier, List<Meal>>((ref) {
  return FavoritesNotifier();
});
