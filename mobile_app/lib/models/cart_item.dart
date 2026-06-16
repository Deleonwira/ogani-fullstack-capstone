class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String? oldPrice;
  final bool isBestSeller;
  final bool isDiscount;
  final String? categoryName;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.oldPrice,
    this.isBestSeller = false,
    this.isDiscount = false,
    this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['productId'].toString(),
      name: json['productName'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] != null ? (json['price'] as num).toDouble() : 0.0,
      imageUrl: json['productImage'] ?? 'https://via.placeholder.com/150',
      oldPrice: json['oldPrice']?.toString(),
      isBestSeller: json['productStatus'] == 'bestseller' || json['productStatus'] == 'Best Seller',
      isDiscount: json['productStatus'] == 'discount',
      categoryName: json['category'] != null ? json['category']['categoryName'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': id,
      'productName': name,
      'description': description,
      'price': price,
      'productImage': imageUrl,
      'oldPrice': oldPrice,
      'productStatus': isDiscount ? 'discount' : (isBestSeller ? 'bestseller' : null),
      'category': categoryName != null ? {'categoryName': categoryName} : null,
    };
  }
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
