import 'package:dio/dio.dart';

import '../models/MealModel.dart';

class MealApi {
  final Dio _dio = Dio();

  Future<List<Meal>> fetchMeals(String url) async {
    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final List<dynamic> mealsJson = data['meals'];

        return mealsJson.map((mealJson) => Meal.fromJson(mealJson)).toList();
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

void printData() async {
  const String apiUrl = 'https://www.themealdb.com/api/json/v1/1/search.php?f=a';

  final mealApi = MealApi();

  try {
    List<Meal> meals = await mealApi.fetchMeals(apiUrl);
    for (var meal in meals) {
      print('Meal ID: ${meal.idMeal}, Meal Name: ${meal.strMeal}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
