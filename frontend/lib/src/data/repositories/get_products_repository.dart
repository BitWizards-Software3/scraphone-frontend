// product_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductRepository {
  Future<List<dynamic>> fetchProducts() async {
    final apiUrl = Uri.parse('http://127.0.0.1:8000/products');
    final response = await http.get(
      apiUrl,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
    );
    print(response.bodyBytes);
    if (response.statusCode == 200) {
      final productData = jsonDecode(utf8.decode(response.bodyBytes));

      return productData;
    } else {
      print('Error al obtener datos de productos');
      print('Código de estado: ${response.statusCode}');
      return [];
    }
  }
}
