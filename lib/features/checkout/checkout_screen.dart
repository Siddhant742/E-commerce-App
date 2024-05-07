import 'package:ecommerce_app/features/checkout/widget/checkout_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/core/provider/cartProvider.dart';
import 'package:ecommerce_app/models/product.dart';

class CheckoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Shipping Details',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  // Shipping details form
                  ShippingDetailsForm(),
                  SizedBox(height: 20.0),
                  Text(
                    'Order Summary',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  Consumer<CartProvider>(
                    builder: (context, cartProvider, child) {
                      List<Product> cartProducts = cartProvider.cartProducts;

                      if (cartProducts.isEmpty) {
                        return Center(
                          child: Text('Your cart is empty.'),
                        );
                      }

                      // Calculate total price
                      double totalPrice = cartProvider.getTotalPrice();

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: cartProducts.length,
                        itemBuilder: (context, index) {
                          Product product = cartProducts[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(product.image),
                            ),
                            title: Text(product.name),
                            subtitle: Text('Quantity: ${product.quantity}'),
                            trailing: Text('\$${product.price.toStringAsFixed(2)}'),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Consumer<CartProvider>(
            builder: (context, cartProvider, child) {
              double totalPrice = cartProvider.getTotalPrice();
              return Container(
                color: Colors.grey[300],
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Place Order button action
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Order Confirmation'),
                              content: Text('Your order has been placed.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Place Order'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
