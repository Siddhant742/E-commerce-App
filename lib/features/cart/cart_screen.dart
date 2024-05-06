import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/core/provider/cartProvider.dart';
import 'package:ecommerce_app/models/product.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          List<Product> cartProducts = cartProvider.cartProducts;

          if (cartProducts.isEmpty) {
            return Center(
              child: Text('Your cart is empty.'),
            );
          }

          return ListView.builder(
            itemCount: cartProducts.length,
            itemBuilder: (context, index) {
              Product product = cartProducts[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(product.image),
                ),
                title: Text(product.name),
                subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () {
                    // Remove the product from the cart
                    Provider.of<CartProvider>(context, listen: false)
                        .removeFromCart(product);
                  },
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          double totalPrice = cartProvider.getTotalPrice();
          return Container(
            height: 50,
            color: Colors.grey[300],
            child: Center(
              child: Text(
                'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
