import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:hive/hive.dart';

const String cartBoxName = 'cartProducts';

class CartProvider extends ChangeNotifier {
  List<Product> _cartProducts = [];

  List<Product> get cartProducts => _cartProducts;

  CartProvider() {
    _loadCartFromHive(); // Load cart data on initialization
  }

  Future<void> _saveCartToHive() async {
    try {
      final box = await Hive.box<Product>(cartBoxName);
      for (var product in _cartProducts) {
        await box.put(product.id, product); // Save each product individually with its id as the key
      }
    } catch (e) {
      print('Error saving cart data: $e');
    }
  }


  Future<void> _loadCartFromHive() async {
    try {
      final box = await Hive.box<Product>(cartBoxName);
      _cartProducts = box.values.toList(); // Load values and convert to list
      notifyListeners();
    } catch (e) {
      print('Error loading cart data: $e');
    }
  }

  void addToCart(Product product) {
    // Check if the product is already in the cart
    bool isInCart = _cartProducts.any((item) => item.id == product.id);

    if (isInCart) {
      // If the product is already in the cart, update its quantity
      _cartProducts.forEach((item) {
        if (item.id == product.id) {
          item.quantity++;
        }
      });
    } else {
      // If the product is not in the cart, add it with quantity 1
      product.quantity = 1;
      _cartProducts.add(product);
    }
    _saveCartToHive();
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartProducts.remove(product);
    _saveCartToHive();
    notifyListeners();
  }

  void clearCart() {
    _cartProducts.clear();
    _saveCartToHive();
    notifyListeners();
  }

  double getTotalPrice() {
    return _cartProducts.fold<double>(
      0,
          (previousValue, element) =>
      previousValue + element.price * element.quantity,
    );
  }

  void updateItemCount(Product product, int newQuantity) {
    // Update the quantity of the specified product
    _cartProducts.forEach((item) {
      if (item.id == product.id) {
        item.quantity = newQuantity;
      }
    });
    _saveCartToHive();
    notifyListeners();
  }
}
