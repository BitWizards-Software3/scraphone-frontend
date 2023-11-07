import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/src/data/models/product_model.dart'; // Update the import path

class ProductRepository {
  Future<void> createProduct(ProductModel product) async {
    print('mierdaaaaaaaaa');
    final apiUrl = Uri.parse('http://127.0.0.1:8000/products');
    print('Datos del producto a enviarxdddddddd: $product');
    final body = json.encode(product.toJson());
    print("perra");
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
}