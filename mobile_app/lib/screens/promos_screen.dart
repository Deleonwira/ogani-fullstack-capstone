import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class PromosScreen extends StatelessWidget {
  const PromosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Ogani', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.bars),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Promos & Coupons', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text('Discover fresh savings on organic goods. Apply these codes at checkout.', style: TextStyle(color: AppTheme.onSurfaceVariant)),
              const SizedBox(height: 24),
              
              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip('All Offers', true),
                    _buildFilterChip('Daily Deals', false),
                    _buildFilterChip('Exclusive', false),
                    _buildFilterChip('Seasonal', false),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Featured Coupon
              _buildFeaturedCoupon(context),
              const SizedBox(height: 16),
              
              // Standard Coupons
              _buildStandardCoupon(
                context,
                icon: CupertinoIcons.cup_hot_fill,
                type: 'Daily Deals',
                title: 'Buy 1 Get 1 Free',
                desc: 'Artisan organic coffee beans. Select roasts only.',
                code: 'BOGOBEANS',
                expiry: 'Expires Today, 11:59 PM',
                isPrimary: false,
              ),
              const SizedBox(height: 16),
              _buildStandardCoupon(
                context,
                icon: CupertinoIcons.star_circle_fill,
                type: 'Exclusive',
                title: '\$10 Off First Order',
                desc: 'Welcome to Ogani! Enjoy a discount on your first delivery.',
                code: 'WELCOME10',
                expiry: 'Valid for new users only',
                isPrimary: true,
              ),
              
              const SizedBox(height: 80), // Bottom nav space
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryContainer.withOpacity(0.1) : AppTheme.surfaceContainerLowest,
          border: Border.all(color: isSelected ? AppTheme.primaryContainer.withOpacity(0.5) : AppTheme.outlineVariant),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppTheme.primaryContainer : AppTheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedCoupon(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBbqzDTGryzDTUVrLwY9NJCcXVfAtLHUt6Yt2SV_yntK5Uj81NnkhiACZu_c8VhgFJKTjgd3Y-flF14jNXdaPc1BaL4cDJAtBAK6f2SJ1m37BlzL0jC4nG7lVnzXG2dTHcoq-2mxADX2ilHsXxmokgOR46i9j1tW-0JrQhoKx41c2wEF8jWLgFODcfI5YjoHGBlRnW-Tagohk2BC-8noc0whzjX7K6_uV8I4Zs1BgzlWdqWypBUgoCWDJ85PQbdyFGWDK3X1c7MP6c7',
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('Featured', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.brown)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(CupertinoIcons.leaf_arrow_circlepath, size: 16, color: AppTheme.primary),
                    const SizedBox(width: 4),
                    Text('Seasonal Harvest', style: TextStyle(color: AppTheme.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                const Text('20% Off Fresh Greens', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Stock up on locally sourced spinach, kale, and mixed greens. Valid for orders over \$30.', style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
                const SizedBox(height: 16),
                const Divider(height: 32, color: Colors.transparent), // Space for dashed line representation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Code', style: TextStyle(color: AppTheme.outline, fontSize: 12)),
                        const Text('FRESH20', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 2)),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(CupertinoIcons.doc_on_clipboard, size: 16),
                      label: const Text('Copy'),
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

  Widget _buildStandardCoupon(
    BuildContext context, {
    required IconData icon,
    required String type,
    required String title,
    required String desc,
    required String code,
    required String expiry,
    required bool isPrimary,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: isPrimary ? AppTheme.primary : AppTheme.secondary),
              const SizedBox(width: 4),
              Text(type, style: TextStyle(color: isPrimary ? AppTheme.primary : AppTheme.secondary, fontSize: 12, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(desc, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
          const SizedBox(height: 16),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(code, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 2)),
              IconButton(icon: const Icon(CupertinoIcons.doc_on_clipboard, color: AppTheme.primary), onPressed: () {}),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isPrimary ? AppTheme.primary : Colors.transparent,
                foregroundColor: isPrimary ? Colors.white : AppTheme.primary,
                side: isPrimary ? null : const BorderSide(color: AppTheme.primary),
              ),
              child: Text(isPrimary ? 'Apply Now' : 'Apply at Checkout'),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(expiry, style: TextStyle(color: AppTheme.outline, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
