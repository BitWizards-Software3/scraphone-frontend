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
    final apiUrl = Uri.parse('http://127.0.0.1:8000/scrape_aliexpress/');

    final response = await http.post(
      apiUrl,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8'
      }, // Especifica la codificación UTF-8
      body: jsonEncode({'search_term': searchTerm}),
    );

    if (response.statusCode == 200) {
      // Decodifica la respuesta utilizando la codificación UTF-8
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

  // Función para abrir el enlace en el navegador
  Future<void> _openLink(String link) async {
    String encodedLink = Uri.encodeFull(link);
    final url = Uri.parse(encodedLink);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'No se pudo abrir el enlace $link';
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
                  return InkWell(
                    // Usamos InkWell para detectar el toque
                    onTap: () => _openLink(productLink), // Abrir el enlace
                    child: ListTile(
                      title: Text(_productData[index]['Product']),
                      subtitle: Text('Price: ${_productData[index]['Price']}'),
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
}
