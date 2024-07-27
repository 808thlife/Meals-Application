import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favorites_provider.dart';

class MealsDetails extends ConsumerWidget {
  const MealsDetails(this.meal, {super.key});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    final bool isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontSize: 19, color: Theme.of(context).colorScheme.onSurface),
        ),
        actions: [
          IconButton(
            icon: AnimatedSwitcher(
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween(begin: 0.8, end: 1.0).animate(animation),
                  child: child,
                );
              },
              duration: const Duration(milliseconds: 300),
              child: Icon(
                !isFavorite ? Icons.star_outline : Icons.star,
                key: ValueKey(isFavorite),
              ),
            ),
            tooltip: 'Add To Favorites',
            onPressed: () {
              final isAdded =
                  ref.read(favoriteMealsProvider.notifier).toggleMealFav(meal);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isAdded
                      ? "Successfully added!"
                      : "Successfully removed!"),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Go Home',
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image(
                image: NetworkImage(meal.imageUrl),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Ingridients: ",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(
              height: 5,
            ),
            for (final ingrident in meal.ingredients)
              Text(
                ingrident,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 14),
              ),
            const SizedBox(
              height: 14,
            ),
            Text(
              "Ingridients: ",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            for (final step in meal.steps)
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 1),
                child: Text(
                  step,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
