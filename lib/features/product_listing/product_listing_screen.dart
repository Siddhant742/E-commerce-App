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

  Future<List<Product>> searchProducts(String searchTerm) async {
    final productList = await readJsonData();
    if (searchTerm.isEmpty) {
      return productList;
    } else {
      return productList
          .where((product) =>
              product.name.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();
    }
  }

  Future<void> _loadData() async {
    final List<Product> productList =
        await searchProducts(searchController.text);
    setState(() {
      products = productList;
    });
  }

  List<List<Product>> selectcategories() {
    List<List<Product>> categoriesProducts = [];
    categoriesProducts.add(products);
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
              title: Text("Ecommerce App"),
            ),
            body: Column(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        margin:
                            EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: (text) => _loadData(),
                          decoration: InputDecoration(
                            hintText: "search",
                            // labelText: 'Search.....',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 20),
                            border: InputBorder.none,
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        width:
                            10),
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
                          _loadData(); // Update products based on category
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
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: searchProducts(searchController.text),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text("${snapshot.error}"));
                      } else {
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: selectedIndex == 0
                              ? snapshot.data?.length ?? 0
                              : selectcategories()[selectedIndex + 1].length,
                          itemBuilder: (BuildContext context, int index) {
                            // Handle both search and category filtering
                            final productList = selectedIndex == 0
                                ? snapshot.data!
                                : selectcategories()[selectedIndex + 1];
                            return ProductCard(product: productList[index]);
                          },
                        );
                      }
                      ;
                    },
                  ),
                ),
              ],
            )));
  }
}
