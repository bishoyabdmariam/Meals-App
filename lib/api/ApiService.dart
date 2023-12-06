import 'package:dio/dio.dart';

import '../models/MealModel.dart';
import '../models/CategoryModel.dart';

class MealApi {
  final Dio _dio = Dio();

  Future<List<Meal>> fetchMealsForLetter(String letter) async {
    try {
      final String apiUrl =
          'https://www.themealdb.com/api/json/v1/1/search.php?f=$letter';
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        // Check if the 'meals' key is present in the response
        if (data.containsKey('meals') && data['meals'] != null) {
          final List<dynamic> mealsJson = data['meals'];
          return mealsJson.map((mealJson) => Meal.fromJson(mealJson)).toList();
        } else {
          // No meals for this letter, return an empty list
          return [];
        }
      } else {
        throw Exception('Failed to load meals for letter $letter');
      }
    } catch (e) {
      // Catch any exception and return an empty list
      return [];
    }
  }
  Future<List<Meal>> fetchMealsForCategory(String category) async {
    try {
      final String apiUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?c=$category";
      print(apiUrl);
       final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        // Check if the 'meals' key is present in the response
        if (data.containsKey('meals') && data['meals'] != null) {
          final List<dynamic> mealsJson = data['meals'];
          return mealsJson.map((mealJson) => Meal.fromJson(mealJson)).toList();
        } else {
          // No meals for this letter, return an empty list
          return [];
        }
      } else {
        throw Exception('Failed to load meals for letter $category');
      }
    } catch (e) {
      // Catch any exception and return an empty list
      print(e.toString());
      print("A&A");
      return [];
    }
  }

  Future<List<Meal>> fetchMeals() async {
    List<Meal> allMeals = [];

    for (var letterCode = 'a'.codeUnitAt(0);
        letterCode <= 'z'.codeUnitAt(0);
        letterCode++) {
      var letter = String.fromCharCode(letterCode);

      List<Meal> mealsForLetter = await fetchMealsForLetter(letter);
      allMeals.addAll(mealsForLetter);
    }

    return allMeals;
  }

  Future<Meal?> fetchRandomMeal() async {
    try {
      const String apiUrl =
          'https://www.themealdb.com/api/json/v1/1/random.php';
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        // Check if the 'meals' key is present in the response
        if (data.containsKey('meals') && data['meals'] != null) {
          final List<dynamic> mealsJson = data['meals'];
          // Since it's a random meal, we expect only one meal in the list
          if (mealsJson.isNotEmpty) {
            return Meal.fromJson(mealsJson.first);
          }
        }
      }

      return null;
    } catch (e) {
      // Catch any exception and return null
      return null;
    }
  }

  Future<Meal?> fetchMealById(String id) async {
    try {
      final String apiUrl =
          'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id';
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        // Check if the 'meals' key is present in the response
        if (data.containsKey('meals') && data['meals'] != null) {
          final List<dynamic> mealsJson = data['meals'];
          // Since it's a random meal, we expect only one meal in the list
          if (mealsJson.isNotEmpty) {
            return Meal.fromJson(mealsJson.first);
          }
        }
      }

      return null;
    } catch (e) {
      // Catch any exception and return null
      return null;
    }
  }


  Future<List<CategoryModel>> fetchCategories() async {
    try {
      const String apiUrl = 'https://www.themealdb.com/api/json/v1/1/categories.php';
      final response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;

        if (data.containsKey('categories') && data['categories'] != null) {
          final List<dynamic> categoriesJson = data['categories'];
          return categoriesJson.map((categoryJson) => CategoryModel.fromJson(categoryJson)).toList();
        } else {
          return [];
        }
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      return [];
    }
  }

}
