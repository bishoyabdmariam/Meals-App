import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealsapp/Screens/MealsScreen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        title: const Text('Meal Explorer'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(const MealListScreen());
              },
              child: const Text('All Meals'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

              },
              child: const Text('List All Categories'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to list all areas screen
                // Replace the following line with your navigation logic
                print('Navigate to list all areas');
              },
              child: const Text('List All Areas'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to list all main ingredients screen
                // Replace the following line with your navigation logic
                print('Navigate to list all main ingredients');
              },
              child: const Text('List All Main Ingredients'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Pick a random meal
                // Replace the following line with your logic to pick a random meal
                print('Pick a random meal');
              },
              child: const Text('Pick a Random Meal'),
            ),
          ],
        ),
      ),
    );
  }
}
