import 'package:ecommerce_app/core/constants.dart';
import 'package:ecommerce_app/features/checkout/checkout_screen.dart';
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
      backgroundColor: kBackgroundColor,
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
                tileColor: Colors.white,
                leading: Container(
                  height: 100,
                  width: 90,
                  decoration: BoxDecoration(
                    // color: kContentColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(product.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('\$${product.price.toStringAsFixed(2)}'),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.remove,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {
                            if (product.quantity > 1) {
                              Provider.of<CartProvider>(context, listen: false)
                                  .updateItemCount(
                                      product, product.quantity - 1);
                            }
                          },
                        ),
                        Text('${product.quantity}'),
                        IconButton(
                          icon: Icon(
                            Icons.add,
                            color: kPrimaryColor,
                          ),
                          onPressed: () {
                            Provider.of<CartProvider>(context, listen: false)
                                .updateItemCount(product, product.quantity + 1);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: kPrimaryColor,
                  ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to CheckoutScreen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckoutScreen()));
                    },
                    child: Text('Checkout'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
