// show_product_card_widget.dart
import 'package:flutter/material.dart';
import 'package:frontend/src/data/models/show_product_model.dart';
import 'package:frontend/src/data/repositories/product_repository.dart';

class ShowProductCardWidget extends StatefulWidget {
  final ProductRepository productRepository;
  final GetProductModel productData;
  final VoidCallback onUpdate;

  ShowProductCardWidget({
    required this.productRepository,
    required this.productData,
    required this.onUpdate,
  });

  @override
  _ShowProductCardWidgetState createState() => _ShowProductCardWidgetState();
}

class _ShowProductCardWidgetState extends State<ShowProductCardWidget> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _shelfController;
  late TextEditingController _stockController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.productData.name);
    _descriptionController =
        TextEditingController(text: widget.productData.description);
    _shelfController = TextEditingController(text: widget.productData.shelf);
    _stockController =
        TextEditingController(text: widget.productData.stock?.toString() ?? '');
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
  // Validar que el campo de stock sea un valor no negativo
  final stockValue = int.tryParse(_stockController.text) ?? 0;
  if (stockValue < 0) {
    // Muestra una alerta de error y no continúes con la actualización
    _showErrorAlert(context, 'Error: El stock no puede ser un valor negativo');
    return;
  }

  final updatedProduct = GetProductModel(
    id: widget.productData.id,
    name: _nameController.text,
    description: _descriptionController.text,
    shelf: _shelfController.text,
    stock: stockValue,
    stock_notification: widget.productData.stock_notification ?? false,
    existence_notification: widget.productData.existence_notification ?? false,
  );

  // Imprime los datos antes de enviar la solicitud
  print('Datos que estás enviando:');
  print(updatedProduct.toJson());

  // Envia la solicitud al repositorio y espera la respuesta
  final response = await widget.productRepository.updateProduct(
    widget.productData.id.toString(),
    updatedProduct,
  );

  // Imprime la respuesta del servidor
  print('Respuesta del servidor:');

  // Puedes realizar acciones adicionales después de la actualización
  widget.onUpdate(); // Llama a la función de actualización externa
}

void _showErrorAlert(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text(message),
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