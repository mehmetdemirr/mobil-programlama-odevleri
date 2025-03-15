import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:project3/models/post_model.dart';

class ApiService {
  final Dio _dio = Dio();
  final Box<PostModel> _postBox = Hive.box<PostModel>('posts');

  Future<List<PostModel>> getPosts({bool forceUpdate = false}) async {
    // Cache'de varsa ve forceUpdate false ise cache'den dön
    if (!forceUpdate && _postBox.isNotEmpty) {
      return _getCachedPosts();
    }

    try {
      // API'den verileri çek
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/posts',
      );

      final List<PostModel> posts =
          (response.data as List)
              .map((post) => PostModel.fromJson(post))
              .toList();

      // Cache'i güncelle
      await _updateCache(posts);
      print("diodan veriler geldi");
      return posts;
    } catch (e) {
      // Hata durumunda cache'de veri varsa onu göster
      if (_postBox.isNotEmpty) {
        return _getCachedPosts();
      }
      rethrow;
    }
  }

  List<PostModel> _getCachedPosts() {
    print("cacheden veriler geldi");
    return _postBox.values.toList()
      ..sort((a, b) => a.id.compareTo(b.id)); // ID'ye göre sırala
  }

  Future<void> _updateCache(List<PostModel> posts) async {
    await _postBox.clear();

    final Map<int, PostModel> postsMap = {
      for (var post in posts) post.id: post,
    };

    await _postBox.putAll(postsMap);
  }
}
