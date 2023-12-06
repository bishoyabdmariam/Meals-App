import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealsapp/Screens/MealsScreen.dart';
import 'package:mealsapp/models/CategoryModel.dart';
import 'package:mealsapp/models/MealModel.dart';
import '../api/ApiService.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key, required this.categories});

  final List<CategoryModel> categories;

  @override
  _CategoryListScreenState createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final MealApi mealApi = MealApi(); // Initialize your MealApi

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
        centerTitle: true,
      ),
      body: widget.categories.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: widget.categories.length,
              itemBuilder: (context, index) {
                CategoryModel category = widget.categories[index];
                return Column(
                  children: [
                    Card(
                      elevation: 2, // Adjust the elevation as needed
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
                        /*subtitle: Text(
                          category.strCategoryDescription,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),*/
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor:
                              Colors.teal, // You can adjust the color
                          backgroundImage: NetworkImage(
                            category.strCategoryThumb,
                          ),
                        ),
                        onTap: () async {
                          print("A&A");
                          print(category.strCategory);
                          List<Meal> meals = await mealApi.fetchMealsForCategory(category.strCategory);
                          Get.to(
                            () => MealListScreen(
                              list: meals,
                            ),
                          );
                          print(meals);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
    );
  }
}
