import 'package:flutter/foundation.dart';
import 'package:project3/models/post_model.dart';
import 'package:project3/services/api_service.dart';

class PostViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<PostModel> _posts = [];
  bool _isLoading = false;
  String? _error;

  List<PostModel> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchPosts({bool forceUpdate = false}) async {
    try {
      _isLoading = true;
      notifyListeners();

      final posts = await _apiService.getPosts(forceUpdate: forceUpdate);
      _posts = posts;
      _error = null;
    } catch (e) {
      _error = 'Veriler yüklenirken bir hata oluştu: ${e.toString()}';
      _posts = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
