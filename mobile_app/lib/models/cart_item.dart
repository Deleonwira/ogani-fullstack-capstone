class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String? oldPrice;
  final bool isBestSeller;
  final bool isDiscount;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.oldPrice,
    this.isBestSeller = false,
    this.isDiscount = false,
  });
}

class CartItem {
  final String id; // Unique ID for cart entry
  final Product product;
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    this.quantity = 1,
  });
}
