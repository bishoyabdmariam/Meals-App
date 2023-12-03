import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import '../controller/AddToCartController.dart';
import '../models/MealModel.dart';

class MealDetailsScreen extends StatefulWidget {
  final Meal meal;

  const MealDetailsScreen({Key? key, required this.meal}) : super(key: key);

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    // Access the CartController using GetX
    final CartController cartController = Get.find<CartController>();
    bool isAdded = cartController.cartItems.contains(widget.meal);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.strMeal ?? ''),
        actions: [
          IconButton(
            icon: isAdded
                ? const Icon(
                    Icons.shopping_cart,
                  )
                : const Icon(
                    Icons.shopping_cart_outlined,
                  ),
            onPressed: () {
              // Add the current meal to the cart
              if (isAdded) {
                Get.closeAllSnackbars();
                cartController.removeFromCart(widget.meal);
                Get.snackbar(
                  'Removed From The Cart',
                  '${widget.meal.strMeal} Removed From your cart.',
                  backgroundColor: Colors.black54,
                  colorText: Colors.white,
                );
              } else {
                Get.closeAllSnackbars();
                cartController.addToCart(widget.meal);
                Get.snackbar(
                  'Added to Cart',
                  '${widget.meal.strMeal} added to your cart.',
                  backgroundColor: Colors.black54,
                  colorText: Colors.white,
                );
              }
              setState(() {
                isAdded = !isAdded;
              });
              // Show a snackbar or any other feedback
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.meal.strMealThumb ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Text(
                    'Category: ${widget.meal.strCategory ?? ''}',
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Area: ${widget.meal.strArea ?? ''}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Instructions: ${widget.meal.strInstructions ?? ''}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                  // Add more details as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
