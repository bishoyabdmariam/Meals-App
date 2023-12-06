import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:mealsapp/api/ApiService.dart';
import 'package:mealsapp/constants/countryCodes.dart';
import 'package:mealsapp/controller/FetchingController.dart';
import 'package:get/get.dart';

import '../models/MealModel.dart';
import 'MealsScreen.dart';

class AreasScreen extends StatelessWidget {
  final MealApi mealApi = MealApi();
  final FetchingController fetchingController = Get.find<FetchingController>();

  AreasScreen({
    super.key,
    required this.areas,
  });

  final List<String> areas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List All Areas'),
        centerTitle: true,
      ),
      body: Obx(
        () => fetchingController.isFetching.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: areas.length,
                itemBuilder: (context, index) {
                  String area = areas[index];
                  return Card(
                    elevation: 2, // Adjust the elevation as needed
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: SizedBox(
                        width: 30,
                        height: 30,
                        child: CountryFlag.fromCountryCode(
                          areasMap[area]??''
                        ),
                      ),
                      title: Text(
                        area,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      onTap: () async {
                        fetchingController.isFetching.value = true;
                        List<Meal> meals = await mealApi
                            .fetchMealsForArea(area);
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
                  );
                },
              ),
      ),
    );
  }
}
