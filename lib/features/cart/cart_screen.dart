import 'package:ecommerce_app/features/checkout/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/models/product.dart';

class CartScreen extends StatefulWidget {
  final List<Product> cartProducts;

  const CartScreen({Key? key, required this.cartProducts}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: widget.cartProducts.length,
        itemBuilder: (context, index) {
          final product = widget.cartProducts[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(product.image),
            ),
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    // Remove item from cart
                    setState(() {
                      widget.cartProducts.removeAt(index);
                    });
                  },
                ),
                Text('1'), // Quantity placeholder
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Add item to cart
                    setState(() {
                      widget.cartProducts.add(product);
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${_calculateTotal().toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {
                  // Proceed to checkout
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckoutScreen()));
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateTotal() {
    double total = 0;
    for (var product in widget.cartProducts) {
      total += product.price;
    }
    return total;
  }
}
