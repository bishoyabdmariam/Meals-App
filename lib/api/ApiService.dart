import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/MealModel.dart';

class MealApi {
  final Dio _dio = Dio();

  Future<List<Meal>> fetchMealsForLetter(String letter) async {
    try {
      final String apiUrl = 'https://www.themealdb.com/api/json/v1/1/search.php?f=$letter';
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
      print('Error fetching meals for letter $letter: $e');
      return [];
    }
  }

  Future<List<Meal>> fetchMeals() async {
    List<Meal> allMeals = [];

    for (var letterCode = 'a'.codeUnitAt(0); letterCode <= 'z'.codeUnitAt(0); letterCode++) {
      var letter = String.fromCharCode(letterCode);

      List<Meal> mealsForLetter = await fetchMealsForLetter(letter);
      allMeals.addAll(mealsForLetter);
    }

    return allMeals;
  }


  Future<Meal?> fetchRandomMeal() async {
    try {
      const String apiUrl = 'https://www.themealdb.com/api/json/v1/1/random.php';
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
      print('Error fetching random meal: $e');
      return null;
    }
  }


}
