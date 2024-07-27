import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals_details.dart';
import 'package:meals_app/widgets/meals/meals_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
    this.categoryTitle,
    this.meals, {
    super.key,
  });

  final String? categoryTitle;
  final List<Meal> meals;

  void _goToDetails(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealsDetails(meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => MealsItem(
        meals[index],
        goToDetails: _goToDetails,
      ),
    );

    if (meals.isEmpty) {
      content = Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "No Meals. Sorry!",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.secondary),
          ),
        ],
      ));
    }

    if (categoryTitle == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: content,
    );
  }
}
