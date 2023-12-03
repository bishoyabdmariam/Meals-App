import 'package:flutter/material.dart';
import '../api/ApiService.dart';
import '../models/MealModel.dart';
import 'CartScreen.dart';
import 'MealListView.dart';

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
        title: const Text("Meals"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the cart screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
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
