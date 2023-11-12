import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  final Map<String, dynamic> productData;

  ProductCardWidget(this.productData);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: ${productData['id']}',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Name: ${productData['name']}',
            ),
            SizedBox(height: 8.0),
            Text(
              'Description: ${productData['description']}',
            ),
            SizedBox(height: 8.0),
            Text(
              'Shelf: ${productData['shelf']}',
            ),
            SizedBox(height: 8.0),
            Text(
              'Stock: ${productData['stock']}',
            ),
            SizedBox(height: 8.0),
            Text(
              'Stock Notification: ${productData['stock_notification']}',
            ),
            SizedBox(height: 8.0),
            Text(
              'Existence Notification: ${productData['existence_notification']}',
            ),
          ],
        ),
      ),
    );
  }
}
