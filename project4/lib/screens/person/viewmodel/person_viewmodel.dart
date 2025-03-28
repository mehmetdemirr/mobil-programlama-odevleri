import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project4/screens/person/model/person_model.dart';

class PersonViewModel extends ChangeNotifier {
  final Dio _dio = Dio();
  List<Person> _people = [];
  List<Person> get people => _people;

  Future<void> fetchPeople([Map<String, dynamic>? filters]) async {
    try {
      final response = await _dio.get(
        'http://localhost:8000/api/people/filter',
        queryParameters: filters != null ? {'filters': filters} : {},
      );

      _people =
          (response.data as List)
              .map((item) => Person(name: item['name'], age: item['age']))
              .toList();

      notifyListeners();
    } catch (e) {
      print('Hata oluştu: $e');
    }
  }
}
