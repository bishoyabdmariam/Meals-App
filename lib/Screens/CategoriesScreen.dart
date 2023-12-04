import 'package:flutter/material.dart';
import 'package:mealsapp/models/CategoryModel.dart';
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
                return ListTile(
                  title: Text(category.strCategory),
                  subtitle: Text(category.strCategoryDescription),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(category.strCategoryThumb),
                  ),
                );
              },
            ),
    );
  }
}
