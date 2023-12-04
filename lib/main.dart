import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mealsapp/Screens/HomeScreen.dart';
import 'package:mealsapp/controller/FetchingController.dart';
import 'Screens/MealsScreen.dart';
import 'controller/AddToCartController.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
      theme: ThemeData(
        primaryColor: Colors.teal,
        hintColor: Colors.orange,
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(CartController());// Initialize CartController
        Get.put(FetchingController());// Initialize CartController
      }),
    );
  }
}
