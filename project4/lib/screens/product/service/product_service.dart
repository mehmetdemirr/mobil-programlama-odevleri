// service/product_service.dart
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:project4/screens/product/model/product_model.dart';

class ProductService {
  // Dio instance'ı oluşturuluyor
  final Dio _dio;

  ProductService()
    : _dio = Dio(BaseOptions(baseUrl: 'https://dummyjson.com/'))
        ..interceptors.add(
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90,
            enabled: true,
            filter: (options, args) {
              // Eğer '/posts' içeren bir istek varsa, o isteği loglama
              if (options.path.contains('/posts')) {
                return false;
              }
              return !args.isResponse || !args.hasUint8ListData;
            },
          ),
        );

  Future<List<Product>> fetchProducts({
    int page = 1,
    int limit = 10,
    String? sortBy,
    String? order,
    List<String>? select,
  }) async {
    final response = await _dio.get(
      'products',
      queryParameters: {
        'skip': (page - 1) * limit,
        'limit': limit,
        'sortBy': sortBy,
        'order': order,
        'select': select?.join(','),
      },
    );
    return (response.data['products'] as List)
        .map((json) => Product.fromJson(json))
        .toList();
  }

  Future<Product> getProductById(int id) async {
    final response = await _dio.get('products/$id');
    return Product.fromJson(response.data);
  }

  Future<List<Product>> searchProducts(String query) async {
    final response = await _dio.get(
      'products/search',
      queryParameters: {'q': query},
    );
    return (response.data['products'] as List)
        .map((json) => Product.fromJson(json))
        .toList();
  }

  Future<Product> addProduct(Product product) async {
    final response = await _dio.post(
      'products/add',
      data: product.toJson(),
      options: Options(contentType: 'application/json'),
    );
    return Product.fromJson(response.data);
  }

  Future<Product> updateProduct(int id, Product product) async {
    final response = await _dio.put(
      'products/$id',
      data: product.toJson(),
      options: Options(contentType: 'application/json'),
    );
    return Product.fromJson(response.data);
  }

  Future<Product> deleteProduct(int id) async {
    final response = await _dio.delete('products/$id');
    return Product.fromJson(response.data);
  }
}


//alan kısmına 
// 10 tane (isim yaş vs toplam 11 tane )
//operatörde  toplam 11 yaş 5 isimde 4 toplam 9 tane şimdilik burası 11 olacak min 