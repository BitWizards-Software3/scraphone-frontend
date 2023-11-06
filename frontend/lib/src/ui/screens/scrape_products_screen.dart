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
                  print("HOLAAAAAAA :D ${_productData[index]}");
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
