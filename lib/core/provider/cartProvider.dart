import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product.dart';

class CartProvider extends ChangeNotifier {
  List<Product> _cartProducts = [];
  List<Product> get cartProducts => _cartProducts;

  void addToCart(Product product) {
    _cartProducts.add(product);
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
      totalPrice += product.price;
    }
    return totalPrice;
  }
}
