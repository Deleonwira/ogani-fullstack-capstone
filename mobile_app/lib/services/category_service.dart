import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'api_client.dart';

class Category {
  final int id;
  final String name;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['categoryId'] ?? 0,
      name: json['categoryName'] ?? '',
      image: json['image'] ?? 'https://via.placeholder.com/150',
    );
  }
}

class CategoryService extends ChangeNotifier {
  List<Category> _categories = [];
  bool _isLoading = false;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiClient.get('/categories');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List list = data['data'];
          _categories = list.map((json) => Category.fromJson(json)).toList();
        }
      }
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
