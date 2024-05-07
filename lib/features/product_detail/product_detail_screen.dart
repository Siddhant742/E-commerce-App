import 'package:ecommerce_app/core/provider/cartProvider.dart';
import 'package:ecommerce_app/features/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.image,
                height: 200,
              ),
            ),
            SizedBox(height: 16),
            Text(
              product.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 18,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              product.description,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Provider.of<CartProvider>(context).addToCart(product);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen()));
                },
                child: Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

