import 'package:flutter/material.dart';
import '../models/MealModel.dart';
import 'MealDetailsScreen.dart';


class MealListView extends StatelessWidget {
  final List<Meal> meals;

  const MealListView({Key? key, required this.meals}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        final meal = meals[index];
        return Card(
          margin: const EdgeInsets.all(8.0),
          elevation: 4.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                meal.strMealThumb ?? '',
              ),
            ),
            title: Text(
              meal.strMeal ?? '',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MealDetailsScreen(
                    meal: meal,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
