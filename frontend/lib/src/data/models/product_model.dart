// scrape_product_model.dart
import 'package:flutter/material.dart';

class ProductModel {
  final String name;
  final String description;
  final String shelf;
  final int stock;
  final bool stock_notification;
  final bool existence_notification;

  ProductModel({
    required this.name,
    required this.description,
    required this.shelf,
    required this.stock,
    required this.stock_notification,
    required this.existence_notification,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'shelf': shelf,
      'stock': stock,
      'stock_notification': stock_notification,
      'existence_notification': existence_notification
    };
  }

  @override
  String toString() {
    return 'ProductModel {name: $name, description: $description, shelf: $shelf, stock: $stock, stock_notification: $stock_notification, existence_notification: $existence_notification }';
  }
}
