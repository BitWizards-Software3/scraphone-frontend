import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  final Map<String, dynamic> productData;

  ProductCardWidget(this.productData);

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
                  buildRow('Nombre', productData['name']),
                  buildRow('Descripción', productData['description']),
                  buildRow('Ubicación', productData['shelf']),
                  buildRow('Stock', productData['stock'].toString()),
                ],
              ),
            ),
            SizedBox(width: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                buildIcon(Icons.edit, Colors.blue, () {
                  // Lógica para editar el producto
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
}