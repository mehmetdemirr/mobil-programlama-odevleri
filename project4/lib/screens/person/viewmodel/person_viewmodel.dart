import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project4/screens/person/model/person_model.dart';

class PersonViewModel extends ChangeNotifier {
  final Dio _dio = Dio();
  List<Person> _people = [];
  List<Person> get people => _people;

  bool isLoading = false;

  void changeLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<void> fetchPeople([Map<String, dynamic>? filters]) async {
    changeLoading(true);
    try {
      final response = await _dio.get(
        'http://localhost:8000/api/people/filter',
        queryParameters: filters != null ? {'filters': filters} : {},
      );

      _people =
          (response.data as List).map((item) => Person.fromJson(item)).toList();

      notifyListeners();
    } catch (e) {
      print('Hata oluştu: $e');
    }
    changeLoading(false);
  }
}
