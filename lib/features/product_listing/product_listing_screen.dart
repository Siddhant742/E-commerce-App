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
  TextEditingController searchController = TextEditingController();

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
      List<Product> categoryProducts = products
          .where((product) => product.category == category.title)
          .toList();
      categoriesProducts.add(categoryProducts);
    }
    return categoriesProducts;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ecommerce App")
        ),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: null,
                      decoration: InputDecoration(
                        hintText: "search",
                        // labelText: 'Search.....',
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10), // Add spacing between search bar and dropdown menu
                DropdownButton(
                  value: selectedIndex,
                  items: List.generate(
                    categoriesList.length,
                        (index) => DropdownMenuItem(
                      child: Text(categoriesList[index].title),
                      value: index,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      selectedIndex = value as int;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Products',
              style:
              TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
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
                      itemCount: selectedIndex == 0
                          ? products.length
                          : selectcategories()[selectedIndex +1].length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductCard(
                          product: selectedIndex == 0
                              ? products[index]
                              : selectcategories()[selectedIndex +1][index],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
