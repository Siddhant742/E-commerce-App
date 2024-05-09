import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _cartProducts = [];
  List<Product> get cartProducts => _cartProducts;

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
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cartProducts.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartProducts.clear();
    notifyListeners();
  }

  double getTotalPrice() {
    double totalPrice = 0;
    for (var product in _cartProducts) {
      totalPrice += product.price * product.quantity;
    }
    return totalPrice;
  }

  void updateItemCount(Product product, int newQuantity) {
    // Update the quantity of the specified product
    _cartProducts.forEach((item) {
      if (item.id == product.id) {
        item.quantity = newQuantity;
      }
    });
    notifyListeners();
  }
}