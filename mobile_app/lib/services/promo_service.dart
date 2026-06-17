import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'api_client.dart';

class Promo {
  final int id;
  final String title;
  final String description;
  final double discountValue;
  final String bannerImageUrl;

  final String promoCode;
  final String expirationDate;
  final double minimumSpend;

  Promo({
    required this.id,
    required this.title,
    required this.description,
    required this.discountValue,
    required this.bannerImageUrl,
    required this.promoCode,
    required this.expirationDate,
    required this.minimumSpend,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      id: json['promoId'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      discountValue: json['discountValue'] != null ? (json['discountValue'] as num).toDouble() : 0.0,
      bannerImageUrl: json['bannerImageUrl'] ?? 'https://via.placeholder.com/600x200',
      promoCode: json['promoCode'] ?? 'CODE',
      expirationDate: json['expirationDate'] ?? 'Limited Time',
      minimumSpend: json['minimumSpend'] != null ? (json['minimumSpend'] as num).toDouble() : 0.0,
    );
  }
}

class PromoService extends ChangeNotifier {
  List<Promo> _promos = [];
  bool _isLoading = false;

  List<Promo> get promos => _promos;
  bool get isLoading => _isLoading;

  Future<void> fetchPromos() async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await ApiClient.get('/promos');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List list = data['data'];
          _promos = list.map((json) => Promo.fromJson(json)).toList();
        }
      }
    } catch (e) {
      debugPrint('Error fetching promos: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<Promo?> validatePromoCode(String code) async {
    try {
      final response = await ApiClient.get('/promos/code/$code');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data['success'] == true && data['data'] != null) {
          return Promo.fromJson(data['data']);
        }
      }
      return null;
    } catch (e) {
      if (kDebugMode) {
        print('Error validating promo code: $e');
      }
      return null;
    }
  }
}
