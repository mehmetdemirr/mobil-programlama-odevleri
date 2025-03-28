// viewmodel/product_view_model.dart
import 'package:flutter/material.dart';
import 'package:project4/screens/product/model/product_model.dart';
import 'package:project4/screens/product/service/product_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _service = ProductService();
  final List<Product> _products = [];
  int _page = 1;
  final int _limit = 10;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  String? _sortBy;
  String? _order;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMore => _hasMore;

  Future<void> fetchProducts({bool loadMore = false}) async {
    if (loadMore) {
      if (_isLoadingMore || !_hasMore) return;
      _isLoadingMore = true;
    } else {
      if (_isLoading) return;
      _isLoading = true;
      _page = 1;
      _hasMore = true;
    }
    notifyListeners();

    try {
      final newProducts = await _service.fetchProducts(
        page: _page,
        limit: _limit,
        sortBy: _sortBy,
        order: _order,
      );

      if (loadMore) {
        _products.addAll(newProducts);
      } else {
        _products.clear();
        _products.addAll(newProducts);
      }

      _hasMore = newProducts.length >= _limit;
      _page++;
    } catch (e) {
      debugPrint("Error fetching products: $e");
    } finally {
      loadMore ? _isLoadingMore = false : _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchProducts(String query) async {
    _isLoading = true;
    notifyListeners();

    try {
      final results = await _service.searchProducts(query);
      _products.clear();
      _products.addAll(results);
    } catch (e) {
      debugPrint("Error searching products: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> sortProducts(String sortBy, String order) async {
    _sortBy = sortBy;
    _order = order;
    await fetchProducts();
  }

  Future<Product?> addProduct(Product product) async {
    try {
      final newProduct = await _service.addProduct(product);
      _products.insert(0, newProduct);
      notifyListeners();
      return newProduct;
    } catch (e) {
      debugPrint("Error adding product: $e");
    }
    return null;
  }

  Future<Product?> updateProduct(int id, Product product) async {
    try {
      final updatedProduct = await _service.updateProduct(id, product);
      final index = _products.indexWhere((p) => p.id == id);
      if (index != -1) {
        _products[index] = updatedProduct;
        notifyListeners();
      }
      return updatedProduct;
    } catch (e) {
      debugPrint("Error updating product: $e");
      print("e:$e");
    }
    return null;
  }

  Future<void> deleteProduct(int id) async {
    try {
      await _service.deleteProduct(id);
      _products.removeWhere((p) => p.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint("Error deleting product: $e");
      rethrow;
    }
  }

  Future<Product> getProductDetails(int id) async {
    try {
      return await _service.getProductById(id);
    } catch (e) {
      debugPrint("Error getting product details: $e");
      rethrow;
    }
  }
}
