import 'package:flutter/material.dart';
import 'package:frontend/src/ui/screens/scrape_products_screen.dart';
import 'package:frontend/src/ui/screens/products_screen.dart';
import 'package:frontend/src/ui/screens/show_products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tu Aplicación Flutter',
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.teal,
      ),
      home: MyHomePage(), // Página de inicio con la pantalla de inventario
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventario'),
        backgroundColor: Colors.teal,
      ),
      body: GetProductsScreen(), // Contenido de la pantalla de inventario
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('Web Scraping'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ScrapeProductsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text('Add Product'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProductForm(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.inventory),
              title: Text('Inventario'),
              onTap: () {
                Navigator.of(context).pop(); // Cerrar el drawer si se selecciona la página actual
              },
            )
          ],
        ),
      ),
    );
  }
}