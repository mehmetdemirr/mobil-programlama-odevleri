import 'package:flutter/material.dart';
import 'package:project4/screens/product/model/product_model.dart';
import 'package:project4/screens/product/viewmodel/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final int id;

  const ProductDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Detayı'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _navigateToEditScreen(context, id),
          ),
        ],
      ),
      body: FutureBuilder<Product>(
        future: provider.getProductDetails(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          }
          final product = snapshot.data!;
          return _buildDetailBody(context, product, provider);
        },
      ),
    );
  }

  Widget _buildDetailBody(
    BuildContext context,
    Product product,
    ProductProvider provider,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              product.title ?? "-",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${product.price}',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(product.description ?? "--"),
            const SizedBox(height: 16),
            Text('Kategori: ${product.category}'),
            const SizedBox(height: 24),
            _buildUpdateButton(context, product, provider),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateButton(
    BuildContext context,
    Product product,
    ProductProvider provider,
  ) {
    return ElevatedButton(
      onPressed: () => _navigateToEditScreen(context, product.id),
      child: const Text('Ürünü Güncelle'),
    );
  }

  void _navigateToEditScreen(BuildContext context, int productId) async {
    final updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductScreen(productId: productId),
      ),
    );

    if (updatedProduct != null) {
      final provider = context.read<ProductProvider>();
      await provider.updateProduct(productId, updatedProduct);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ürün başarıyla güncellendi')),
      );
    }
  }
}

class EditProductScreen extends StatefulWidget {
  final int productId;

  const EditProductScreen({super.key, required this.productId});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _categoryController;

  @override
  void initState() {
    super.initState();
    final provider = context.read<ProductProvider>();
    final product = provider.products.firstWhere(
      (p) => p.id == widget.productId,
    );

    _titleController = TextEditingController(text: product.title);
    _priceController = TextEditingController(text: product.price.toString());
    _descriptionController = TextEditingController(text: product.description);
    _categoryController = TextEditingController(text: product.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ürünü Düzenle')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
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
                maxLines: 3,
              ),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Kategori'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Kaydet'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final updatedProduct = Product(
        id: widget.productId,
        title: _titleController.text,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        category: _categoryController.text,
        thumbnail: '', // API'ye göre gerekli alanları ekleyin
      );
      Navigator.pop(context, updatedProduct);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }
}
