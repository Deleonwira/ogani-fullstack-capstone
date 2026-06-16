import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import 'wishlist_screen.dart';
import 'reviews_screen.dart';
import '../models/cart_item.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import 'auth/login_screen.dart';
import '../services/wishlist_service.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(CupertinoIcons.back, color: AppTheme.onSurface),
                  onPressed: () => Navigator.pop(context),
                  iconSize: 20,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Consumer<WishlistService>(
                    builder: (context, wishlistService, child) {
                      final isWishlisted = wishlistService.wishlistItems.any((item) => item.id == product.id);
                      return IconButton(
                        icon: Icon(
                          isWishlisted ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                          color: isWishlisted ? Colors.red : AppTheme.onSurface,
                        ),
                        onPressed: () {
                          final auth = Provider.of<AuthProvider>(context, listen: false);
                          if (!auth.isAuthenticated) {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                            return;
                          }
                          if (isWishlisted) {
                            wishlistService.removeFromWishlist(product.id);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.name} removed from wishlist')));
                          } else {
                            wishlistService.addToWishlist(product.id);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.name} added to wishlist')));
                          }
                        },
                        iconSize: 20,
                      );
                    },
                  ),
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: CachedNetworkImage(
                imageUrl: product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: AppTheme.surface,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name, style: Theme.of(context).textTheme.headlineMedium),
                              const SizedBox(height: 4),
                              Text(product.description, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            if (product.oldPrice != null)
                              Text(product.oldPrice!, style: TextStyle(decoration: TextDecoration.lineThrough, color: AppTheme.outline)),
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: product.isDiscount ? AppTheme.secondary : AppTheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text('Product Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(
                      'This is a fresh, high-quality organic product sourced directly from local farms to ensure the best taste and nutrition. Perfect for your daily healthy lifestyle.',
                      style: TextStyle(color: AppTheme.onSurfaceVariant, height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        const Icon(CupertinoIcons.star_fill, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        const Text('4.8 (120 reviews)', style: TextStyle(fontWeight: FontWeight.bold)),
                        const Spacer(),
                        TextButton(onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => ReviewsScreen(product: product)));
                        }, child: const Text('See all')),
                      ],
                    ),
                    const SizedBox(height: 100), // Space for bottom bar
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            )
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    final auth = Provider.of<AuthProvider>(context, listen: false);
                    if (!auth.isAuthenticated) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                      return;
                    }
                    Provider.of<CartProvider>(context, listen: false).addItem(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.name} added to cart')),
                    );
                    Navigator.pop(context); // Go back after adding
                  },
                  icon: const Icon(CupertinoIcons.cart_badge_plus),
                  label: const Text('Add to Cart', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
