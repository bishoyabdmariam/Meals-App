import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/AddToCartController.dart';
import '../models/MealModel.dart';

class MealDetailsScreen extends StatefulWidget {
  final Meal meal;

  const MealDetailsScreen({Key? key, required this.meal}) : super(key: key);

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  bool isAdded = false;

  List<String> getIngredients() {
    final List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = widget.meal.getIngredient(i);
      if (ingredient != null && ingredient.trim().isNotEmpty) {
        ingredients.add(ingredient);
      }
    }
    return ingredients;
  }


  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    isAdded = cartController.cartItems.contains(widget.meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.strMeal ?? ''),
        actions: [
          IconButton(
            icon: isAdded
                ? const Icon(Icons.shopping_cart)
                : const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
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
                  ElevatedButton(
                    onPressed:widget.meal.strYoutube==null ? null : () async{
                      await launchUrl(Uri.parse(widget.meal.strYoutube!) );
                    },
                    child: const Text('Watch Video'),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      _showIngredientsDialog(context);
                    },
                    child: const Text('Show Ingredients'),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      _showInstructionsDialog(context);
                    },
                    child: const Text('Show Instructions'),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Area Flag: ${widget.meal.strArea ?? ''}', // Add the flag here
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showIngredientsDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ingredients'),
          content: SingleChildScrollView(
            child: ListBody(
              children: getIngredients()
                  .map<Widget>((ingredient) => Text(ingredient))
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showInstructionsDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Instructions'),
          content: SingleChildScrollView(
            child: Text(widget.meal.strInstructions ?? ''),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
