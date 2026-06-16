import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'api_client.dart';
import '../models/cart_item.dart';
import '../providers/auth_provider.dart';

class WishlistService extends ChangeNotifier {
  List<Product> _wishlistItems = [];
  bool _isLoading = false;
  final AuthProvider authProvider;

  WishlistService({required this.authProvider});

  List<Product> get wishlistItems => _wishlistItems;
  bool get isLoading => _isLoading;

  Future<void> fetchWishlist() async {
    if (authProvider.user == null) return;
    
    _isLoading = true;
    notifyListeners();

    try {
      final userId = authProvider.user!['userId'];
      final response = await ApiClient.get('/wishlists/user/$userId');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List list = data['data'];
          _wishlistItems = list.map((json) => Product.fromJson(json['product'])).toList();
        }
      }
    } catch (e) {
      debugPrint('Error fetching wishlist: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addToWishlist(String productId) async {
    if (authProvider.user == null) return false;

    try {
      final userId = authProvider.user!['userId'];
      final response = await ApiClient.post('/wishlists/user/$userId/product/$productId', {});
      if (response.statusCode == 200) {
        await fetchWishlist();
        return true;
      }
    } catch (e) {
      debugPrint('Error adding to wishlist: $e');
    }
    return false;
  }

  Future<bool> removeFromWishlist(String productId) async {
    if (authProvider.user == null) return false;

    try {
      final userId = authProvider.user!['userId'];
      final response = await ApiClient.delete('/wishlists/user/$userId/product/$productId');
      if (response.statusCode == 200) {
        await fetchWishlist();
        return true;
      }
    } catch (e) {
      debugPrint('Error removing from wishlist: $e');
    }
    return false;
  }
}
