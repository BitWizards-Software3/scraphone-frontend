import 'package:flutter/material.dart';
import 'package:frontend/src/data/models/product_model.dart';
import 'package:frontend/src/ui/widgets/create_product_form_widget.dart';
import 'package:frontend/src/data/repositories/product_repository.dart'; // Import the UserRepository

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final stockController = TextEditingController();
  final shelfController = TextEditingController();
  final productRepository =
      ProductRepository(); // Create an instance of UserRepository

  void _submitForm(ProductModel ProductData) async {
    print('Datos del producto a enviar: $ProductData');

    try {
      await productRepository.createProduct(
          ProductData); // Use the UserRepository to create a user
      // Handle the success response if needed
      print('Producto creado exitosamente');
    } catch (error) {
      // Handle the error
    }

    // Clear the form after submission
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear producto'),
        backgroundColor: Colors.teal, // Set the app bar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormWidget(
          formKey: _formKey,
          nameController: nameController,
          descriptionController: descriptionController,
          stockController: stockController,
          shelfController: shelfController,
          onSubmit: _submitForm,
        ),
      ),
    );
  }
}
