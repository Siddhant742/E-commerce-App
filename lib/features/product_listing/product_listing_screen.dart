import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/features/product_listing/widget/product_card.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/categories.dart';
import 'package:flutter/services.dart' as services;

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({Key? key}) : super(key: key);

  @override
  _ProductListingScreenState createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  List<Product> products = [];
  int selectedIndex = 0;

  Future<List<Product>> readJsonData() async {
    final jsonData =
    await services.rootBundle.loadString('assets/productList.json');
    final list = json.decode(jsonData) as List<dynamic>;
    return list.map((e) => Product.fromJson(e)).toList();
  }

  Future<void> _loadData() async {
    final List<Product> productList = await readJsonData();
    setState(() {
      products = productList;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  List<List<Product>> selectcategories() {
    List<List<Product>> categoriesProducts = [];
    // All products
    categoriesProducts.add(products);
    // Filter products by category
    for (var category in categoriesList) {
      List<Product> categoryProducts = products.where((product) => product.category == category.title).toList();
      categoriesProducts.add(categoryProducts);
    }
    return categoriesProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Listing'),
      ),
      body: Column(
        children: [
          categoryItems(),
          Expanded(
            child: FutureBuilder(
              future: readJsonData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                } else {
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: selectedIndex == 0 ? products.length : selectcategories()[selectedIndex + 1].length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                        product: selectedIndex == 0 ? products[index] : selectcategories()[selectedIndex + 1][index],
                      );
                    },
                  );

                }
              },
            ),
          ),
        ],
      ),
    );
  }

  SizedBox categoryItems() {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoriesList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: selectedIndex == index ? Colors.blue[200] : Colors.transparent,
              ),
              child: Column(
                children: [
                  Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(categoriesList[index].image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    categoriesList[index].title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
