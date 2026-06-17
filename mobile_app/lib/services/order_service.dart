import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'api_client.dart';
import '../models/cart_item.dart';
import '../models/order.dart';

class OrderService extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> createOrder({
    required int userId,
    required List<CartItem> items,
    required double totalAmount,
    required double subtotalAmount,
    required double shippingCost,
    required String shippingAddress,
    required String receiverName,
    required String receiverPhone,
    String? promoCode,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final orderData = {
        'user': {'userId': userId},
        'totalPrice': totalAmount,
        'subtotalAmount': subtotalAmount,
        'shippingCost': shippingCost,
        'shippingAddress': shippingAddress,
        'receiverName': receiverName,
        'receiverPhone': receiverPhone,
        'orderStatus': 'pending',
        if (promoCode != null) 'promoCode': promoCode,
        'invoiceCode': 'INV-${DateTime.now().millisecondsSinceEpoch}',
        'orderDetails': items.map((item) => {
          'product': {'productId': int.parse(item.product.id)},
          'quantity': item.quantity,
          'priceAtOrder': item.product.price,
          'subtotal': item.product.price * item.quantity,
        }).toList(),
      };

      final response = await ApiClient.post('/orders', orderData);
      
      _isLoading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      debugPrint('Error creating order: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<List<Order>> fetchMyOrders(int userId) async {
    try {
      final response = await ApiClient.get('/orders/user/$userId');
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final List<dynamic> ordersJson = data['data'];
          return ordersJson.map((json) => Order.fromJson(json)).toList();
        }
      }
      return [];
    } catch (e) {
      debugPrint('Error fetching orders: $e');
      return [];
    }
  }
}
