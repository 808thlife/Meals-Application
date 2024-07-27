import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meals/meals_item_metadata.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsItem extends StatelessWidget {
  const MealsItem(this.meal, {super.key, required this.goToDetails});

  final Meal meal;
  final void Function(BuildContext context, Meal meal) goToDetails;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordability {
    return meal.affordability.name[0].toUpperCase() +
        meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 50,
      child: InkWell(
        onTap: () {
          goToDetails(context, meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: const Color.fromARGB(134, 31, 29, 28),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis, //...
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealsItemMetadata(
                          icon: Icons.schedule,
                          label: "${meal.duration} minutes",
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealsItemMetadata(
                          icon: Icons.layers_rounded,
                          label: complexityText,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        MealsItemMetadata(
                          icon: Icons.attach_money_sharp,
                          label: affordability,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
