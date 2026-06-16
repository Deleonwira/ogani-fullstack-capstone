import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import 'api_client.dart';

class ProductService extends ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiClient.get('/products');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List list = data['data'];
          _products = list.map((json) => Product.fromJson(json)).toList();
        }
      }
    } catch (e) {
      debugPrint('Error fetching products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}
