import 'dart:convert';

import 'package:flutter/material.dart';
import '../../routes/routes.dart';
import '../product_detail/product_detail_screen.dart';
import 'package:ecommerce_app/models/product.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      price: json['price'].toDouble(),
      image: json['image'],
    );
  }
}

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    // Parse JSON data and initialize products list
    String jsonStr = '''
    {
      "products": [
        {
          "id": "1",
          "name": "Wireless Bluetooth Headphones",
          "category": "Electronics",
          "description": "High-quality wireless headphones with noise cancellation and 12-hour battery life.",
          "price": 99.99,
          "image": "https://example.com/images/product1.jpg"
        },
        {
          "id": "2",
          "name": "Organic Green Tea",
          "category": "Groceries",
          "description": "A soothing blend of organic green tea leaves from the mountains of Himachal.",
          "price": 15.50,
          "image": "https://example.com/images/product2.jpg"
        }
      ]
    }
    ''';
    Map<String, dynamic> jsonData = json.decode(jsonStr);
    List<dynamic> productsData = jsonData['products'];
    products = productsData.map((data) => Product.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Listing'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          Product product = products[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(),
                ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(product.image),
              ),
              title: Text(product.name),
              subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.cart);
                },
                child: Text('Add to Cart'),
              ),
            ),
          );
        },
      ),
    );
  }
}
