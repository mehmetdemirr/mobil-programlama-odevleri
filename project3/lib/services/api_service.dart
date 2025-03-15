import 'package:dio/dio.dart';
import 'package:project3/models/post_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<List<Post>> getPosts() async {
    final response = await _dio.get(
      'https://jsonplaceholder.typicode.com/posts',
    );
    return (response.data as List).map((post) => Post.fromJson(post)).toList();
  }
}
