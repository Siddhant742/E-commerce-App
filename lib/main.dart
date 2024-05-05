import 'package:ecommerce_app/features/product_listing/product_listing_screen.dart';
import 'package:flutter/material.dart';
import 'core/nav_bar_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:NavBarScreen() ,
      debugShowCheckedModeBanner: false,
    );
  }
}

