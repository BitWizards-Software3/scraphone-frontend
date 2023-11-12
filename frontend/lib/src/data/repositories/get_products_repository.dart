// product_repository.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:frontend/src/data/models/show_product_model.dart'; // Asegúrate de ajustar la ruta de importación

class ShowProductRepository {
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