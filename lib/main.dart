import 'package:flutter/material.dart';
import 'package:mealsapp/Screens/MealDetailsScreen.dart';

import 'api/ApiService.dart';
import 'models/MealModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MealListScreen(),
      theme: ThemeData(
        primaryColor: Colors.teal, // Change the primary color
        hintColor: Colors.orange, // Change the accent color
      ),
    );
  }
}

class MealListScreen extends StatefulWidget {
  const MealListScreen({Key? key}) : super(key: key);

  @override
  _MealListScreenState createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  final MealApi mealApi = MealApi();
  late Future<List<Meal>> futureMeals;

  @override
  void initState() {
    super.initState();
    futureMeals = mealApi.fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal App'),
      ),
      body: Center(
        child: FutureBuilder<List<Meal>>(
          future: futureMeals,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No meals found');
            } else {
              return MealListView(meals: snapshot.data!);
            }
          },
        ),
      ),
    );
  }
}

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
            // You can display more information here if needed
          ),
        );
      },
    );
  }
}
