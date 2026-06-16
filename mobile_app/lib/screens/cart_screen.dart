import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../providers/cart_provider.dart';
import 'checkout_screen.dart';
import '../models/cart_item.dart';
import 'checkout_screen.dart';
import '../models/cart_item.dart';
import '../providers/auth_provider.dart';
import 'auth/login_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Ogani', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.search),
          onPressed: () {},
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: const CachedNetworkImageProvider(
                  'https://i.pravatar.cc/150?img=11'),
              radius: 16,
            ),
          ),
        ],
      ),
      body: !Provider.of<AuthProvider>(context).isAuthenticated 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.person_crop_circle_badge_xmark, size: 80, color: AppTheme.outlineVariant),
                const SizedBox(height: 16),
                Text('Please login to use Cart', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                  child: const Text('Login / Register'),
                ),
              ],
            ),
          )
        : Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(CupertinoIcons.cart, size: 80, color: AppTheme.outlineVariant),
                        const SizedBox(height: 16),
                        Text('Your cart is empty', style: Theme.of(context).textTheme.headlineMedium),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: cart.items.length + 1, // +1 for the title
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text('My Cart', style: Theme.of(context).textTheme.headlineMedium),
                        );
                      }
                      final cartItem = cart.items.values.toList()[index - 1];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: _buildCartItem(context, cartItem),
                      );
                    },
                  ),
          ),
          
          // Checkout Bottom Section
          if (cart.items.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                border: Border(top: BorderSide(color: AppTheme.outlineVariant.withValues(alpha: 0.5), width: 1)),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Subtotal', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                        Text('\$${cart.subtotalAmount.toStringAsFixed(2)}', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Delivery Fee', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                        Text('\$${cart.deliveryFee.toStringAsFixed(2)}', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: cart.items.isEmpty ? null : () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const CheckoutScreen()));
                        },
                        child: const Text('Checkout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartItem item) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.outlineVariant, width: 1.0),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: item.product.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), maxLines: 1, overflow: TextOverflow.ellipsis)),
                    GestureDetector(
                      onTap: () => cart.removeItem(item.product.id),
                      child: const Icon(CupertinoIcons.trash, color: AppTheme.error, size: 18),
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Text(item.product.description, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${item.product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.primary)),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(CupertinoIcons.minus, size: 16, color: AppTheme.primary),
                            onPressed: () {
                              cart.decrementQuantity(item.product.id);
                            },
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(),
                          ),
                          Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(CupertinoIcons.add, size: 16, color: AppTheme.primary),
                            onPressed: () {
                              cart.incrementQuantity(item.product.id);
                            },
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
