import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealsapp/Screens/MealsScreen.dart';
import 'package:mealsapp/api/ApiService.dart';

import '../models/MealModel.dart';
import 'MealDetailsScreen.dart';
import 'package:mealsapp/controller/FetchingController.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FetchingController fetchingController =
        Get.find<FetchingController>();

    final MealApi mealApi = MealApi();
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
              onPressed: () {},
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
              onPressed: () async {
                if (fetchingController.isFetching.value) {
                  return; // Do nothing if already fetching
                }

                try {
                  fetchingController.isFetching.value =
                      true; // Set fetching state to true
                  Meal? randomMeal = await mealApi.fetchRandomMeal();

                  if (randomMeal != null) {
                    Get.to(() => MealDetailsScreen(meal: randomMeal));
                  } else {
                    Get.snackbar(
                      'Error',
                      'Failed to fetch a random meal. Please try again.',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                } finally {
                  fetchingController.isFetching.value =
                      false; // Set fetching state to false regardless of success or failure
                }
              },
              child: Obx(
                () => fetchingController.isFetching.value
                    ? const CircularProgressIndicator() // Show circular progress indicator when fetching
                    : const Text('Pick a Random Meal'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
