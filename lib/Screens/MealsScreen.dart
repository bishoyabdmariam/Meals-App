import 'package:flutter/material.dart';
import '../api/ApiService.dart';
import '../models/MealModel.dart';
import 'CartScreen.dart';
import 'MealListView.dart';

class MealListScreen extends StatefulWidget {
  const MealListScreen({super.key ,required this.list});

final List<Meal> list;
  @override
  _MealListScreenState createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  final MealApi mealApi = MealApi();

  @override
  void initState() {
    super.initState();
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
        child:
               MealListView(meals: widget.list)

      ),


    );
  }
}
