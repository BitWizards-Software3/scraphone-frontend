import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/src/data/models/product_model.dart'; // Update the import path
import 'package:frontend/src/data/models/show_product_model.dart';
class ProductRepository {
  Future<void> createProduct(ProductModel product) async {
    final apiUrl = Uri.parse('http://127.0.0.1:8000/products');
    final body = json.encode(product.toJson());
    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    // Verifica si la solicitud fue exitosa
    if (response.statusCode == 200) {
      // La solicitud fue exitosa, puedes manejar la respuesta aquí si es necesario.
      print('Producto creado exitosamente');
      // Puedes redirigir al usuario a otra página o mostrar un mensaje de éxito.
    } else {
      // Hubo un error en la solicitud, puedes manejarlo aquí.
      print('Error al crear el Producto');
      print('Código de estado: ${response.statusCode}');
      // Puedes mostrar un mensaje de error al usuario.
    }
  }

  Future<void> updateProduct(String productId, GetProductModel updatedProduct) async {
    final updateUrl = Uri.parse('http://127.0.0.1:8000/products/$productId'); // Suponiendo una estructura de URL similar a '/products/:id'

    try {
      final response = await http.put(
        updateUrl,
        body: {
          'name': updatedProduct.name,
          'description': updatedProduct.description,
          'shelf': updatedProduct.shelf,
          'stock': updatedProduct.stock.toString(),
        },
      );

      if (response.statusCode == 200) {
        // Éxito, el producto ha sido actualizado
      } else {
        // Manejar errores aquí
        print('Error al actualizar el producto. Código de estado: ${response.statusCode}');
      }
    } catch (error) {
      // Manejar errores de red aquí
      print('Error de red al actualizar el producto: $error');
    }
  }


}
