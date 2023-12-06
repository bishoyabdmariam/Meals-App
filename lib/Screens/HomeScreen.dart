import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealsapp/Screens/AreasScreen.dart';
import 'package:mealsapp/Screens/CategoriesScreen.dart';
import 'package:mealsapp/Screens/MealsScreen.dart';
import 'package:mealsapp/api/ApiService.dart';

import '../models/CategoryModel.dart';
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
        child: Obx(
          () => fetchingController.isFetching.value
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (fetchingController.isFetching.value) {
                          return; // Do nothing if already fetching
                        }

                        try {
                          fetchingController.isFetching.value =
                              true; // Set fetching state to true
                          List<Meal> meals = await mealApi.fetchMeals();

                          if (meals.isNotEmpty) {
                            Get.to(
                              () => MealListScreen(
                                list: meals,
                              ),
                            );
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
                      child: const Text('All Meals'),
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
                          List<CategoryModel> categories =
                              await mealApi.fetchCategories();

                          Get.to(
                              () => CategoryListScreen(categories: categories));
                        } finally {
                          fetchingController.isFetching.value =
                              false; // Set fetching state to false regardless of success or failure
                        }
                      },
                      child: const Text('List All Categories'),
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
                          List<String> areas = await mealApi.fetchAreas();

                          if (areas.isNotEmpty) {
                            // Handle the areas data as needed, you can navigate to a new screen or display them in a dialog
                            if (kDebugMode) {
                              print('Areas: $areas');
                            }
                            Get.to(() => AreasScreen(areas: areas));
                          } else {
                            Get.snackbar(
                              'Error',
                              'Failed to fetch areas. Please try again.',
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        } finally {
                          fetchingController.isFetching.value =
                              false; // Set fetching state to false regardless of success or failure
                        }
                      },
                      child: const Text('List All Areas'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to list all main ingredients screen
                        // Replace the following line with your navigation logic
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
                      child: const Text('Pick a Random Meal'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
