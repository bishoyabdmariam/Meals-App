import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/AddToCartController.dart'; // Import your cart controller
import '../models/MealModel.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: (){},
        child: const Text("Process to CheckOut"),
      ),
      appBar: AppBar(
        title: const Text('My Cart'),
        centerTitle: true,
      ),
      body: cartController.cartItems.isEmpty
          ? const Center(
        child: Text("There is no meals in the Cart, try adding some."),
      )
          : ListView.builder(
        itemCount: cartController.cartItems.length,
        itemBuilder: (context, index) {
          final Meal cartItem = cartController.cartItems.keys.toList()[index];
          final int quantity = cartController.cartItems[cartItem]!;

          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 4.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(cartItem.strMealThumb ?? ''),
              ),
              title: Text(cartItem.strMeal ?? ''),
              subtitle: Text('Category: ${cartItem.strCategory ?? ''}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      // Decrease quantity
                      cartController.removeFromCart(cartItem);
                      setState(() {});
                    },
                  ),
                  Text('$quantity'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      // Increase quantity
                      cartController.addToCart(cartItem);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
