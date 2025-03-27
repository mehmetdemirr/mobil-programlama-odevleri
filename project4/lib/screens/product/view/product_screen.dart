import 'package:flutter/material.dart';
import 'package:project4/screens/product/model/product_model.dart';
import 'package:project4/screens/product/view/add_product_screen.dart';
import 'package:project4/screens/product/view/filter_dialog_widget.dart';
import 'package:project4/screens/product/view/product_detail_screen.dart';
import 'package:project4/screens/product/viewmodel/product_view_model.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  void _scrollListener() {
    final provider = context.read<ProductProvider>();
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    const scrollThreshold = 100.0;

    if (maxScroll - currentScroll <= scrollThreshold &&
        !provider.isLoadingMore &&
        provider.hasMore) {
      provider.fetchProducts(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          "Ürünler",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort, color: Colors.white),
            onPressed: () => _showSortDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
              elevation: 5.0,
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  if (value.length >= 3) {
                    provider.searchProducts(_searchController.text);
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Ürün ara...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.blueAccent),
                    onPressed: () {
                      if (_searchController.text.length >= 3) {
                        provider.searchProducts(_searchController.text);
                      } else {
                        showSnackbar(
                          context,
                          "Lütfen minimum 3 harf giriniz !",
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: _buildProductList(provider)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddProductDialog(context),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildProductList(ProductProvider provider) {
    if (provider.isLoading && provider.products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: provider.products.length + (provider.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= provider.products.length) {
          return _buildLoadingIndicator(provider);
        }
        final product = provider.products[index];
        return _buildProductItem(product, provider);
      },
    );
  }

  Widget _buildLoadingIndicator(ProductProvider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child:
            provider.isLoadingMore
                ? const CircularProgressIndicator()
                : const Text('Daha fazla ürün yok'),
      ),
    );
  }

  Widget _buildProductItem(Product product, ProductProvider provider) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        title: Text(
          product.title ?? "-",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          '\$${product.price}',
          style: TextStyle(color: Colors.green),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () => provider.deleteProduct(product.id),
        ),
        onTap:
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(id: product.id),
              ),
            ),
      ),
    );
  }

  void _showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => FilterDialog(),

      // AlertDialog(
      //   backgroundColor: Colors.white,
      //   title: const Text(
      //     'Filtrele',
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   content: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       // ListTile(
      //       //   title: const Text(
      //       //     'İsme göre (A-Z)',
      //       //     style: TextStyle(color: Colors.blueAccent),
      //       //   ),
      //       //   onTap: () {
      //       //     context.read<ProductProvider>().sortProducts(
      //       //       'title',
      //       //       'asc',
      //       //     );
      //       //     Navigator.pop(context);
      //       //   },
      //       // ),
      //       // ListTile(
      //       //   title: const Text(
      //       //     'Fiyata göre (Artan)',
      //       //     style: TextStyle(color: Colors.blueAccent),
      //       //   ),
      //       //   onTap: () {
      //       //     context.read<ProductProvider>().sortProducts(
      //       //       'price',
      //       //       'asc',
      //       //     );
      //       //     Navigator.pop(context);
      //       //   },
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }

  void _showAddProductDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AddProductDialog(
            onSave:
                (product) =>
                    context.read<ProductProvider>().addProduct(product),
          ),
    );
  }

  void showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
      duration: Duration(seconds: 2), // Mesajın ne kadar süre gösterileceği
      backgroundColor: Colors.blueAccent, // Mesajın arka plan rengi
      action: SnackBarAction(
        label: 'Undo',
        textColor: Colors.white,
        onPressed: () {
          // Undo işlemi yapılabilir
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
