import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/AddToCartController.dart';
import '../models/MealModel.dart';
import 'CartScreen.dart';

class MealDetailsScreen extends StatefulWidget {
  final Meal meal;

  const MealDetailsScreen({
    Key? key,
    required this.meal,
  }) : super(key: key);

  @override
  State<MealDetailsScreen> createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  late CartController cartController;
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
    cartController = Get.find<CartController>();
    isAdded = cartController.cartItems.keys.contains(widget.meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.strMeal ?? ''),
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.plus_one_outlined,
                ),
                onPressed: () {
                  Get.closeAllSnackbars();
                  cartController.addToCart(widget.meal);
                  Get.snackbar(
                    'Added to Cart',
                    '${widget.meal.strMeal} added to your cart.',
                    backgroundColor: Colors.black54,
                    colorText: Colors.white,
                  );

                  setState(() {});
                },
              ),
              if (cartController.cartItems.isNotEmpty)
                Positioned(
                  right: 1,
                  top: 1,
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 8,
                    child: Text(
                      cartController.cartItems.length.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.meal.strMealThumb ?? ''),
                    fit: BoxFit.cover,
                  ),
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
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    children: [
                      Text(
                        'Area: ${widget.meal.strArea ?? ''}',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 30,
                        height: 30,
                        child: CountryFlag.fromCountryCode(
                          widget.meal.strArea!.substring(0, 2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: widget.meal.strYoutube == null
                              ? null
                              : () async {
                                  await launchUrl(Uri.parse(
                                    widget.meal.strYoutube!,
                                  ));
                                },
                          child: const Text('Watch Video'),
                        ),
                        const SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            _showIngredientsDialog(context);
                          },
                          child: const Text('Show Ingredients'),
                        ),
                        const SizedBox(width: 10.0),
                        ElevatedButton(
                          onPressed: () {
                            _showInstructionsDialog(context);
                          },
                          child: const Text('Show Instructions'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Number of ${widget.meal.strMeal ?? ''} in the cart: ${cartController.cartItems[widget.meal] ?? 0}',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(const CartScreen());
                      },
                      child: const Text('Cart Details'),
                    ),
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

  void _onCartPressed() {
    Get.to(() => const CartScreen());
  }

/*
  void launchUrl(Uri uri) async {
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch $uri';
    }
  }

*/
}
