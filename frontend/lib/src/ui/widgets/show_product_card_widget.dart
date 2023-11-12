import 'package:flutter/material.dart';
import 'package:frontend/src/data/models/product_model.dart';
import 'package:frontend/src/data/models/show_product_model.dart';
import 'package:frontend/src/data/repositories/product_repository.dart';

class ProductCardWidget extends StatefulWidget {
  final ProductRepository productRepository;
  final Map<String, dynamic> productData;

  ProductCardWidget({
    required this.productRepository,
    required this.productData, required Future<void> Function() onUpdate,
  });

  @override
  _ProductCardWidgetState createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _shelfController;
  late TextEditingController _stockController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.productData['name']);
    _descriptionController =
        TextEditingController(text: widget.productData['description']);
    _shelfController = TextEditingController(text: widget.productData['shelf']);
    _stockController = TextEditingController(text: widget.productData['stock'].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildRow('Nombre', _nameController.text),
                  buildRow('Descripción', _descriptionController.text),
                  buildRow('Ubicación', _shelfController.text),
                  buildRow('Stock', _stockController.text),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildIcon(Icons.edit, Colors.blue, () {
                  _showUpdateDialog(context);
                }),
                SizedBox(width: 8.0),
                buildIcon(Icons.delete, Colors.red, () {
                  // Lógica para eliminar el producto
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String label, String value) {
    return Row(
      children: [
        Text('$label: ', style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  Widget buildIcon(IconData icon, Color color, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      color: color,
    );
  }

  Future<void> _showUpdateDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Actualizar Producto'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Descripción'),
                ),
                TextFormField(
                  controller: _shelfController,
                  decoration: InputDecoration(labelText: 'Ubicación'),
                ),
                TextFormField(
                  controller: _stockController,
                  decoration: InputDecoration(labelText: 'Stock'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                _updateProduct();
                Navigator.of(context).pop();
              },
              child: Text('Actualizar'),
            ),
          ],
        );
      },
    );
  }

  void _updateProduct() async {
    final updatedProduct = GetProductModel(
      id: widget.productData['id'],
      name: _nameController.text,
      description: _descriptionController.text,
      shelf: _shelfController.text,
      stock: int.tryParse(_stockController.text) ?? 0,
      stock_notification: widget.productData['stock_notification'],
      existence_notification: widget.productData['existence_notification'],
          );

    await widget.productRepository.updateProduct(widget.productData['id'], updatedProduct);

    // Puedes realizar acciones adicionales después de la actualización
    // ...
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _shelfController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}