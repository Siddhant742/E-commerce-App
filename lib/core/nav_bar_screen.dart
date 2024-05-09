import 'package:flutter/material.dart';
import 'package:ecommerce_app/features/cart/cart_screen.dart';
import 'package:ecommerce_app/features/checkout/checkout_screen.dart';
import 'package:ecommerce_app/features/product_detail/product_detail_screen.dart';
import 'package:ecommerce_app/features/product_listing/product_listing_screen.dart';
import 'package:ecommerce_app/core/constants.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({Key? key}) : super(key: key);

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  int currentIndex = 1;

  List<Widget> screens = [
    Scaffold(), // Placeholder for the first screen
    ProductListingScreen(),
    CartScreen(),
    CheckoutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: 1,
        height: 60,
        color: Color(0xFF6747B6),
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // IconButton(
            //   onPressed: () {
            //     setState(() {
            //       currentIndex = 0;
            //     });
            //   },
            //   icon: Icon(
            //     Icons.home,
            //     size: 30,
            //     color: currentIndex == 0 ? Colors.white : kPrimaryColor,
            //   ),
            // ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 1;
                });
              },
              icon: Icon(
                Icons.grid_view_rounded,
                size: 30,
                color: currentIndex == 1 ? Colors.white : kPrimaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 2;
                });
              },
              icon: Icon(
                Icons.shopping_cart,
                size: 30,
                color: currentIndex == 2 ? Colors.white : kPrimaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  currentIndex = 3;
                });
              },
              icon: Icon(
                Icons.shopping_cart_checkout,
                size: 30,
                color: currentIndex == 3 ? Colors.white : kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
      body: screens[currentIndex],
    );
  }
}
