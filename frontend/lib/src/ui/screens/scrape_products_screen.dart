import 'package:flutter/material.dart';
import 'package:frontend/src/data/repositories/scraping_product_repository.dart';
import 'package:frontend/src/ui/widgets/product_card_widget.dart';

class ScrapeProductsScreen extends StatefulWidget {
  @override
  _ScrapeProductsScreenState createState() => _ScrapeProductsScreenState();
}

class _ScrapeProductsScreenState extends State<ScrapeProductsScreen> {
  final _searchTermController = TextEditingController();
  final ProductRepository _productRepository = ProductRepository();
  List<dynamic> _productData = [];
  bool _isLoading = false;

  Future<void> _fetchProductData() async {
    setState(() {
      _isLoading = true;
    });

    final searchTerm = _searchTermController.text;
    final products = await _productRepository.fetchProducts(searchTerm);

    setState(() {
      _productData = products;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scrape Products'),
        backgroundColor: Colors.teal, // Set the app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _searchTermController,
              decoration: InputDecoration(labelText: 'Término de búsqueda'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isLoading ? null : _fetchProductData,
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Set the button color
                onPrimary: Colors.white, // Set the text color
              ),
              child: Text('Buscar'),
            ),
            SizedBox(height: 16.0),
            _isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.teal),
                  )
                : Expanded(
                    child: _productData.isEmpty
                        ? Center(
                            child: Text('No se encontraron productos.'),
                          )
                        : ListView.builder(
                            itemCount: _productData.length,
                            itemBuilder: (context, index) {
                              return ProductCardWidget(_productData[index]);
                            },
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}