import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/category_item.dart';
import 'package:meals_app/screens/meals.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.filteredMeals,
  });

  final List<Meal> filteredMeals; //filtered by filter in settings.

  void _selectCategory(BuildContext context, Category category) {
    final _filteredMeals = filteredMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          category.title,
          _filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20),
      children: [
        for (final category in availableCategories)
          CategoryItem(
            category,
            () {
              _selectCategory(context, category);
            },
          ),
      ],
    );
  }
}
