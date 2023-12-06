import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealsapp/Screens/MealsScreen.dart';
import 'package:mealsapp/models/CategoryModel.dart';
import 'package:mealsapp/models/MealModel.dart';
import '../api/ApiService.dart';
import '../controller/FetchingController.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({
    super.key,
    required this.categories,
  });

  final List<CategoryModel> categories;

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final MealApi mealApi = MealApi();
  final FetchingController fetchingController = Get.find<FetchingController>();

  // Initialize your MealApi

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (fetchingController.isFetching.value ||
              widget.categories.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                CategoryModel category = widget.categories[index];
                return Column(
                  children: [
                    Card(
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(
                          category.strCategory,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.teal,
                          backgroundImage: NetworkImage(
                            category.strCategoryThumb,
                          ),
                        ),
                        onTap: () async {
                          fetchingController.isFetching.value = true;
                          List<Meal> meals = await mealApi
                              .fetchMealsForCategory(category.strCategory);
                          for (int i = 0; i < meals.length; i++) {
                            meals[i] = (await mealApi
                                .fetchMealById(meals[i].idMeal!))!;
                          }
                          Get.to(
                            () => MealListScreen(
                              list: meals,
                            ),
                          );
                          fetchingController.isFetching.value = false;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}
