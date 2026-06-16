import 'order_detail.dart';

class Order {
  final int orderId;
  final String invoiceCode;
  final double totalPrice;
  final double subtotalAmount;
  final double shippingCost;
  final double discountAmount;
  final String orderStatus;
  final String orderTime;
  final String? estimatedArrival;
  final String receiverName;
  final String receiverPhone;
  final String shippingAddress;
  final List<OrderDetail> orderDetails;

  Order({
    required this.orderId,
    required this.invoiceCode,
    required this.totalPrice,
    required this.subtotalAmount,
    required this.shippingCost,
    required this.discountAmount,
    required this.orderStatus,
    required this.orderTime,
    this.estimatedArrival,
    required this.receiverName,
    required this.receiverPhone,
    required this.shippingAddress,
    this.orderDetails = const [],
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    var detailsList = json['orderDetails'] as List? ?? [];
    List<OrderDetail> details = detailsList.map((i) => OrderDetail.fromJson(i)).toList();

    return Order(
      orderId: json['orderId'] ?? 0,
      invoiceCode: json['invoiceCode'] ?? '',
      totalPrice: (json['totalPrice'] ?? 0).toDouble(),
      subtotalAmount: (json['subtotalAmount'] ?? 0).toDouble(),
      shippingCost: (json['shippingCost'] ?? 0).toDouble(),
      discountAmount: (json['discountAmount'] ?? 0).toDouble(),
      orderStatus: json['orderStatus'] ?? 'pending',
      orderTime: json['orderTime'] ?? '',
      estimatedArrival: json['estimatedArrival'],
      receiverName: json['receiverName'] ?? '',
      receiverPhone: json['receiverPhone'] ?? '',
      shippingAddress: json['shippingAddress'] ?? '',
      orderDetails: details,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'invoiceCode': invoiceCode,
      'totalPrice': totalPrice,
      'subtotalAmount': subtotalAmount,
      'shippingCost': shippingCost,
      'discountAmount': discountAmount,
      'orderStatus': orderStatus,
      'orderTime': orderTime,
      'estimatedArrival': estimatedArrival,
      'receiverName': receiverName,
      'receiverPhone': receiverPhone,
      'shippingAddress': shippingAddress,
      'orderDetails': orderDetails.map((v) => v.toJson()).toList(),
    };
  }
}
