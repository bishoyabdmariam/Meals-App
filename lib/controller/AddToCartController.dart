import 'package:get/get.dart';

import '../models/MealModel.dart';

class CartController extends GetxController {
  RxMap cartItems = {}.obs;

  void addToCart(Meal meal) {
    if (cartItems.containsKey(meal)) {
      cartItems[meal] = cartItems[meal]! + 1;
    } else {
      cartItems[meal] = 1;
    }
    // You can add additional logic if needed
  }

  void removeFromCart(Meal meal) {
    if (cartItems.containsKey(meal)) {
      if (cartItems[meal]! > 1) {
        cartItems[meal] = cartItems[meal]! - 1;
      } else {
        cartItems.remove(meal);
      }
    }
    // You can add additional logic if needed
  }
}
