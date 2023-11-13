// get_product_model.dart
class GetProductModel {
  final int id;
  final String name;
  final String description;
  final String shelf;
  final int stock;
  final bool stock_notification;
  final bool existence_notification;

  GetProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.shelf,
    required this.stock,
    required this.stock_notification,
    required this.existence_notification,
  });

  factory GetProductModel.fromJson(Map<String, dynamic> json) {
    return GetProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      shelf: json['shelf'],
      stock: json['stock'],
      stock_notification: json['stock_notification'],
      existence_notification: json['existence_notification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'shelf': shelf,
      'stock': stock,
      'stock_notification': stock_notification,
      'existence_notification': existence_notification,
    };
  }

  @override
  String toString() {
    return 'GetProductModel { id: $id,name: $name, description: $description, shelf: $shelf, stock: $stock, stock_notification: $stock_notification, existence_notification: $existence_notification }';
  }
}