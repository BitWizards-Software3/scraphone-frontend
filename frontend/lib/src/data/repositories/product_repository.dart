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
  final updateUrl = Uri.parse('http://127.0.0.1:8000/products/$productId');

  try {
    final response = await http.put(
      updateUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'id': updatedProduct.id,
        'name': updatedProduct.name,
        'description': updatedProduct.description,
        'shelf': updatedProduct.shelf,
        'stock': updatedProduct.stock,
        'stock_notification': updatedProduct.stock_notification,
        'existence_notification': updatedProduct.existence_notification,
      }),
    );

    if (response.statusCode == 200) {
      print('Producto actualizado exitosamente');
    } else {
      // Manejar errores aquí
      print('Error al actualizar el producto. Código de estado: ${response.statusCode}');
      print(utf8.decode(response.bodyBytes));
    }
  } catch (error) {
    // Manejar errores de red aquí
    print('Error de red al actualizar el producto: $error');
  }
}


    Future<List<GetProductModel>> fetchProducts() async {
    final apiUrl = Uri.parse('http://127.0.0.1:8000/products');
    final response = await http.get(
      apiUrl,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> productData = jsonDecode(utf8.decode(response.bodyBytes));
      
      // Convierte cada elemento en la lista a una instancia de ShowProductModel
      List<GetProductModel> products = productData.map((json) => GetProductModel.fromJson(json)).toList();

      return products;
    } else {
      print('Error al obtener datos de productos');
      print('Código de estado: ${response.statusCode}');
      return [];
    }
  }


}
