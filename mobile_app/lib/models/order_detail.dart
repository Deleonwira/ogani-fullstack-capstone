import 'cart_item.dart';

class OrderDetail {
  final int detailId;
  final Product? product;
  final int quantity;
  final double priceAtOrder;
  final double subtotal;

  OrderDetail({
    required this.detailId,
    this.product,
    required this.quantity,
    required this.priceAtOrder,
    required this.subtotal,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      detailId: json['detailId'] ?? 0,
      product: json['product'] != null ? Product.fromJson(json['product']) : null,
      quantity: json['quantity'] ?? 0,
      priceAtOrder: (json['priceAtOrder'] ?? 0).toDouble(),
      subtotal: (json['subtotal'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'detailId': detailId,
      'product': product?.toJson(),
      'quantity': quantity,
      'priceAtOrder': priceAtOrder,
      'subtotal': subtotal,
    };
  }
}
