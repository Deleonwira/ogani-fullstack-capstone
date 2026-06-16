import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'api_client.dart';

class Review {
  final int id;
  final int productId;
  final String userName;
  final int rating;
  final String title;
  final String content;
  final String date;

  Review({
    required this.id,
    required this.productId,
    required this.userName,
    required this.rating,
    required this.title,
    required this.content,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['reviewId'] ?? 0,
      productId: json['product'] != null ? json['product']['productId'] : 0,
      userName: json['user'] != null ? json['user']['fullName'] : 'Anonymous',
      rating: json['rating'] ?? 5,
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      date: json['reviewDate'] ?? '',
    );
  }
}

class ReviewService extends ChangeNotifier {
  List<Review> _reviews = [];
  bool _isLoading = false;

  List<Review> get reviews => _reviews;
  bool get isLoading => _isLoading;

  Future<void> fetchReviews() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiClient.get('/reviews');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List list = data['data'];
          _reviews = list.map((json) => Review.fromJson(json)).toList();
        }
      }
    } catch (e) {
      debugPrint('Error fetching reviews: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  List<Review> getReviewsForProduct(String productId) {
    return _reviews.where((r) => r.productId.toString() == productId).toList();
  }
}
