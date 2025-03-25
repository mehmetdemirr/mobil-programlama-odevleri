// add_product_dialog.dart
import 'package:flutter/material.dart';
import 'package:project4/screens/product/model/product_model.dart';

class AddProductDialog extends StatefulWidget {
  final Function(Product) onSave;

  const AddProductDialog({super.key, required this.onSave});

  @override
  _AddProductDialogState createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Yeni Ürün Ekle'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Başlık'),
                validator: (value) => value!.isEmpty ? 'Zorunlu alan' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Fiyat'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Zorunlu alan' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Açıklama'),
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('İptal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newProduct = Product(
                id: DateTime.now().millisecondsSinceEpoch,
                title: _titleController.text,
                price: double.parse(_priceController.text),
                description: _descriptionController.text,
                category: _categoryController.text,
                thumbnail: '',
              );
              widget.onSave(newProduct);
              Navigator.pop(context);
            }
          },
          child: const Text('Kaydet'),
        ),
      ],
    );
  }
}
