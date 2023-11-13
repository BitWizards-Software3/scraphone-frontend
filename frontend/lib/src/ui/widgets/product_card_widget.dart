import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCardWidget extends StatelessWidget {
  final Map<String, dynamic> productData;

  ProductCardWidget(this.productData);

  @override
  Widget build(BuildContext context) {
    String productLink = productData['Link'];
    String productImage = productData['Image'];

    return Card(
      child: InkWell(
        onTap: () => _openLink(productLink),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProductImage(productImage),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Producto: ${productData['Product']}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Precio en COP: ${productData['Price']}',
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Comprar en: ${_obtenerPagina(productLink)}',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openLink(String link) async {
    String encodedLink = Uri.encodeFull(link);
    final url = Uri.parse(encodedLink);

    if (await canLaunch(url.toString())) {
      await launch(url.toString());
    } else {
      throw 'No se pudo abrir el enlace $link';
    }
  }

  Widget _buildProductImage(String productImage) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.network(
        productImage,
        width: 100,
        height: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 100,
            height: 100,
            color: Colors.grey[300],
            child: Center(
              child: Icon(Icons.error),
            ),
          );
        },
      ),
    );
  }

  String _obtenerPagina(String link) {
    if (link.contains("alibaba")) {
      return "Alibaba";
    } else if (link.contains("aliexpress")) {
      return "Aliexpress";
    }
    return "Otro";
  }
}
