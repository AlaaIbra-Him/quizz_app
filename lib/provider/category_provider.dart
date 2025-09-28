import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:my_sec_app/models/category_model.dart';

class CategoryProvider with ChangeNotifier {
  final Dio _dio = Dio();
  List<CategoryModel> _categories = [];
  bool _isLoading = false;

  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.get("https://opentdb.com/api_category.php");
      final List data = response.data['trivia_categories'];

      _categories = data.map((e) => CategoryModel.fromJson(e)).toList();
    } catch (e) {
      debugPrint("Error fetching categories: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
