import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrape Products',
      home: ScrapeProductsWidget(),
    );
  }
}

class ScrapeProductsWidget extends StatefulWidget {
  @override
  _ScrapeProductsWidgetState createState() => _ScrapeProductsWidgetState();
}

class _ScrapeProductsWidgetState extends State<ScrapeProductsWidget> {
  final _searchTermController = TextEditingController();
  List<dynamic> _productData = [];
  bool _isLoading = false;

  Future<void> _fetchProductData() async {
    setState(() {
      _isLoading = true;
    });

    final searchTerm = _searchTermController.text;
    final apiUrl = Uri.parse('http://127.0.0.1:8000/scrape_both/');

    final response = await http.post(
      apiUrl,
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'search_term': searchTerm}),
    );

    if (response.statusCode == 200) {
      final productData =
          jsonDecode(utf8.decode(response.bodyBytes))['productos'];
      setState(() {
        _productData = productData;
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      print('Error al obtener datos de productos');
      print('Código de estado: ${response.statusCode}');
    }
  }

  Future<void> _openLink(String link) async {
    String encodedLink = Uri.encodeFull(link);
    final url = Uri.parse(encodedLink);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'No se pudo abrir el enlace $link';
    }
  }

  Widget _buildProductImage(String productImage) {
    try {
      return Image.network(
        productImage,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
              Icons.error); // Puedes cambiar esto a una imagen de reemplazo
        },
      );
    } catch (e) {
      print('Error al cargar la imagen: $e');
      return Icon(Icons.error); // Devuelve un icono de error en caso de error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrape Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchTermController,
              decoration: InputDecoration(labelText: 'Término de búsqueda'),
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchProductData,
              child: Text('Buscar'),
            ),
            _isLoading ? CircularProgressIndicator() : SizedBox(),
            Expanded(
              child: ListView.builder(
                itemCount: _productData.length,
                itemBuilder: (context, index) {
                  var productLink = _productData[index]['Link'];
                  var productImage = _productData[index]['Image'];

                  return Card(
                    child: InkWell(
                      onTap: () => _openLink(productLink),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            _buildProductImage(productImage),
                            SizedBox(
                                width: 16.0), // Espacio entre imagen y texto
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Producto: ${_productData[index]['Product']}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Precio en COP: ${_productData[index]['Price']}',
                                  ),
                                  Text(
                                    'Comprar en: ${obtenerPagina(_productData[index]['Link'])}',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  obtenerPagina(String link) {
    if (link.contains("alibaba")) {
      return "Alibaba";
    } else if (link.contains("aliexpress")) {
      return "Aliexpress";
    }
  }
}
