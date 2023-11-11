// product_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductRepository {
  Future<List<dynamic>> fetchProducts(String searchTerm) async {
    final apiUrl = Uri.parse('http://192.168.20.6:8000/scrape_both/');

    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'search_term': searchTerm}),
    );

    if (response.statusCode == 200) {
      final productData =
          jsonDecode(utf8.decode(response.bodyBytes))['productos'];
      return productData;
    } else {
      print('Error al obtener datos de productos');
      print('Código de estado: ${response.statusCode}');
      return [];
    }
  }
}
