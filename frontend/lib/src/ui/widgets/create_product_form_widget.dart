import 'package:flutter/material.dart';
import 'package:frontend/src/data/models/product_model.dart';

class FormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController stockController;
  final TextEditingController descriptionController;
  final TextEditingController shelfController;
  final Function(ProductModel) onSubmit;

  FormWidget({
    required this.formKey,
    required this.nameController,
    required this.stockController,
    required this.descriptionController,
    required this.shelfController,
    required this.onSubmit,
  });

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  bool stockNotification = false;
  bool existenceNotification = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: widget.nameController,
            decoration: InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingresa el nombre';
              }
              return null;
            },
          ),
          SizedBox(height: 12.0),
          TextFormField(
            controller: widget.descriptionController,
            decoration: InputDecoration(
              labelText: 'Descripción',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingresa la descripción';
              }
              return null;
            },
          ),
          SizedBox(height: 12.0),
          TextFormField(
            controller: widget.shelfController,
            decoration: InputDecoration(
              labelText: 'Estante',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingresa en donde está ubicado el producto';
              }
              return null;
            },
          ),
          SizedBox(height: 12.0),
          TextFormField(
            controller: widget.stockController,
            decoration: InputDecoration(
              labelText: 'Stock',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingresa el stock';
              }
              return null;
            },
          ),
          SizedBox(height: 12.0),
          SwitchListTile(
            title: Text('Notificación de Stock'),
            value: stockNotification,
            onChanged: (value) {
              setState(() {
                stockNotification = value;
              });
            },
            activeColor: Colors.teal,
          ),
          SwitchListTile(
            title: Text('Notificación de Existencia'),
            value: existenceNotification,
            onChanged: (value) {
              setState(() {
                existenceNotification = value;
              });
            },
            activeColor: Colors.teal,
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              if (widget.formKey.currentState!.validate()) {
                widget.formKey.currentState!.save();
                final productData = ProductModel(
                  name: widget.nameController.text,
                  description: widget.descriptionController.text,
                  shelf: widget.shelfController.text,
                  stock: int.parse(widget.stockController.text),
                  stock_notification: stockNotification,
                  existence_notification: existenceNotification,
                );
                widget.onSubmit(productData);
                widget.formKey.currentState!.reset();
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.teal,
              onPrimary: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text('Crear Producto'),
          ),
        ],
      ),
    );
  }
}




