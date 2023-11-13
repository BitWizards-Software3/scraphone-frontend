// get_products_screen.dart
import 'package:flutter/material.dart';
import 'package:frontend/src/data/models/show_product_model.dart';
import 'package:frontend/src/data/repositories/product_repository.dart';
import 'package:frontend/src/ui/widgets/show_product_card_widget.dart';

class GetProductsScreen extends StatefulWidget {
  @override
  _GetProductsScreenState createState() => _GetProductsScreenState();
}

class _GetProductsScreenState extends State<GetProductsScreen> {
  final ProductRepository _showProductRepository = ProductRepository();
  List<GetProductModel> _productData = [];
  bool _isLoading = false;
  TextEditingController _searchController = TextEditingController();

  Future<void> _fetchProductData() async {
    setState(() {
      _isLoading = true;
    });

    final products = await _showProductRepository.fetchProducts();

    setState(() {
      _productData = products;
      _isLoading = false;
    });
  }

  void _searchProducts(String query) {
    List<GetProductModel> filteredProducts = _productData.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _productData = filteredProducts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _searchProducts,
                    decoration: InputDecoration(
                      labelText: 'Buscar por nombre',
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: _isLoading ? null : _fetchProductData,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    onPrimary: Colors.white,
                  ),
                  child: Text('Buscar'),
                ),
              ],
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
                              return ShowProductCardWidget(
                                productRepository: ProductRepository(), // Reemplaza ProductRepository con tu repositorio real
                                productData: _productData[index],
                                onUpdate: _fetchProductData,
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