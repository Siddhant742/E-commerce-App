import 'package:flutter/material.dart';
import 'package:ecommerce_app/features/product_listing/product_listing_screen.dart';
import '../features/cart/cart_screen.dart';
import '../features/checkout/checkout_screen.dart';
import '../features/product_detail/product_detail_screen.dart';
import '../models/product.dart';

class Routes {
  static const String productListing = '/productListing';
  static const String productDetail = '/productDetail';
  static const String cart = '/cart';
  static const String checkout = '/checkout';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case productListing:
        return MaterialPageRoute(builder: (_) => ProductListingScreen());
      case productDetail:
        return MaterialPageRoute(builder: (_) => ProductDetailScreen(product: settings.arguments as Product));
      case cart:
        return MaterialPageRoute(builder: (_) => CartScreen(cartProducts: [],));
      case checkout:
        return MaterialPageRoute(builder: (_) => CheckoutScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Error'),
          ),
          body: Center(
            child: Text('Page not found'),
          ),
        );
      },
    );
  }
}

