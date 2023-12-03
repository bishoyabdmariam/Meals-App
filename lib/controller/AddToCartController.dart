import 'package:get/get.dart';

import '../models/MealModel.dart';

class CartController extends GetxController {
  RxList<Meal> cartItems = <Meal>[].obs;

  void addToCart(Meal meal) {
    cartItems.add(meal);
    // You can add additional logic if needed
  }

  void removeFromCart(Meal meal) {
    cartItems.remove(meal);
    // You can add additional logic if needed
  }
}
