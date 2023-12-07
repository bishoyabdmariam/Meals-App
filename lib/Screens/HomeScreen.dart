import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealsapp/Screens/AreasScreen.dart';
import 'package:mealsapp/api/ApiService.dart';
import 'package:mealsapp/controller/FetchingController.dart';

import '../models/CategoryModel.dart';
import '../models/MealModel.dart';
import 'CategoriesScreen.dart';
import 'MealDetailsScreen.dart';
import 'MealsScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FetchingController fetchingController =
        Get.find<FetchingController>();

    final MealApi mealApi = MealApi();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Meals'),
        centerTitle: true,
      ),
      body: Obx(
        () => fetchingController.isFetching.value
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 16,
                    ),
                    AnimatedDefaultTextStyle(
                      duration: Duration(
                        milliseconds: 300,
                      ),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      child: Text(
                        'Loading...',
                      ),
                    ),
                  ],
                ),
              )
            : Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    color: Colors.white54,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 200,
                              child: Image.asset(
                                "assets/images/newMeal.png",
                                alignment: Alignment.center,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          top: 40,
                          right: 5,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Center(
                              child: Text(
                                'NEW',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Try It Now!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20.0,
                        childAspectRatio: 1,
                        children: [
                          _buildGridItem(
                            image: "assets/images/allmeals.jfif",
                            label: 'Our Meals',
                            onPressed: () async {
                              await _fetchAndNavigate(() async {
                                List<Meal> meals = await mealApi.fetchMeals();
                                Get.to(() => MealListScreen(list: meals));
                              });
                            },
                          ),
                          _buildGridItem(
                            image: "assets/images/categories.jpg",
                            label: 'Categories',
                            onPressed: () async {
                              await _fetchAndNavigate(() async {
                                List<CategoryModel> categories =
                                    await mealApi.fetchCategories();
                                Get.to(() =>
                                    CategoryListScreen(categories: categories));
                              });
                            },
                          ),
                          _buildGridItem(
                            image: "assets/images/world.png",
                            label: 'Areas We Support',
                            onPressed: () async {
                              await _fetchAndNavigate(() async {
                                List<String> areas = await mealApi.fetchAreas();
                                if (areas.isNotEmpty) {
                                  Get.to(() => AreasScreen(areas: areas));
                                } else {
                                  showFetchErrorSnackbar('areas');
                                }
                              });
                            },
                          ),
                          _buildGridItem(
                            image: "assets/images/random meals.jfif",
                            label: 'Random Meal',
                            onPressed: () async {
                              await _fetchAndNavigate(() async {
                                Meal? randomMeal =
                                    await mealApi.fetchRandomMeal();
                                if (randomMeal != null) {
                                  Get.to(() =>
                                      MealDetailsScreen(meal: randomMeal));
                                } else {
                                  showFetchErrorSnackbar('random meal');
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildGridItem({
    required String image,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Material(
        elevation: 3.0,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: const Border.symmetric(
                vertical: BorderSide(color: Colors.white70, width: 1),
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _fetchAndNavigate(Future<void> Function() fetchFunction) async {
    final FetchingController fetchingController =
        Get.find<FetchingController>();
    if (fetchingController.isFetching.value) {
      return;
    }

    try {
      fetchingController.isFetching.value = true;
      await fetchFunction();
    } finally {
      // Move setting isFetching to false after navigation
      Future.delayed(const Duration(seconds: 2), () {
        fetchingController.isFetching.value = false;
      });
    }
  }

  void showFetchErrorSnackbar(String item) {
    Get.snackbar(
      'Error',
      'Failed to fetch $item. Please try again.',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}
