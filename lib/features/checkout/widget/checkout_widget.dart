import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShippingDetailsForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Full Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Address'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'City'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Postal Code'),
        ),
      ],
    );
  }
}

