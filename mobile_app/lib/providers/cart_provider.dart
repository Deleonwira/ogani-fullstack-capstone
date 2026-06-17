import 'package:flutter/material.dart';
import 'dart:math';
import '../models/cart_item.dart';
import '../services/promo_service.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartItem> _items = {};
  Promo? _appliedPromo;

  Promo? get appliedPromo => _appliedPromo;

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get subtotalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }

  double get deliveryFee {
    // Basic logic: free delivery if cart > $50, else $2.00
    if (subtotalAmount == 0.0) return 0.0;
    return subtotalAmount > 50.0 ? 0.0 : 2.00;
  }

  double get discountAmount => _appliedPromo?.discountValue ?? 0.0;

  double get totalAmount {
    return max(0.0, subtotalAmount - discountAmount) + deliveryFee;
  }

  Future<String?> applyPromoCode(String code) async {
    if (code.isEmpty) return 'Please enter a promo code';
    
    final promoService = PromoService();
    final promo = await promoService.validatePromoCode(code);
    
    if (promo == null) {
      return 'Invalid promo code';
    }
    
    if (subtotalAmount < promo.minimumSpend) {
      return 'Minimum spend of \$${promo.minimumSpend.toStringAsFixed(2)} required for this promo';
    }
    
    _appliedPromo = promo;
    notifyListeners();
    return null; // Success
  }

  void removePromoCode() {
    _appliedPromo = null;
    notifyListeners();
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      // Increment quantity
      _items.update(
        product.id,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          product: existingCartItem.product,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      // Add new item
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: DateTime.now().toString(),
          product: product,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void incrementQuantity(String productId) {
    if (!_items.containsKey(productId)) return;
    _items.update(
      productId,
      (existing) => CartItem(
        id: existing.id,
        product: existing.product,
        quantity: existing.quantity + 1,
      ),
    );
    notifyListeners();
  }

  void decrementQuantity(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existing) => CartItem(
          id: existing.id,
          product: existing.product,
          quantity: existing.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    _appliedPromo = null;
    notifyListeners();
  }
}
