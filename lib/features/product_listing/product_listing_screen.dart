import 'dart:convert';

import 'package:ecommerce_app/features/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import '../product_detail/product_detail_screen.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/services.dart' as services;


class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  List<Product> products = [];
  Future<List<Product>> ReadJsonData() async {
    final jsonData = await services.rootBundle.loadString(
        'assets/productList.json');
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => Product.fromJson(e)).toList();
  }

  Future<void> _loadData() async {
    final List<Product> productList = await ReadJsonData();
    setState(() {
      products = productList;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Listing'),
      ),
      body: FutureBuilder(
        future: ReadJsonData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else {
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                Product product = products[index];
                return GestureDetector(
                  onTap: () {
                    // Handle onTap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailScreen(product: product),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CartScreen(cartProducts: [])));
                      },
                      child: Text('Add to Cart'),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}