import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../services/promo_service.dart';

class PromosScreen extends StatefulWidget {
  const PromosScreen({super.key});

  @override
  State<PromosScreen> createState() => _PromosScreenState();
}

class _PromosScreenState extends State<PromosScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PromoService>(context, listen: false).fetchPromos();
    });
  }

  void _copyToClipboard(BuildContext context, String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Code $code copied to clipboard!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Promos', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<PromoService>(
        builder: (context, promoService, child) {
          if (promoService.isLoading) {
            return const Center(child: CircularProgressIndicator(color: AppTheme.primary));
          }

          if (promoService.promos.isEmpty) {
            return const Center(child: Text('No promos available at the moment.'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Promos & Coupons', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 8),
                  Text('Discover fresh savings on organic goods. Apply these codes at checkout.', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                  const SizedBox(height: 24),
                  
                  ...promoService.promos.map((promo) {
                    bool isFeatured = promo == promoService.promos.first;
                    
                    if (isFeatured) {
                      return Column(
                        children: [
                           _buildFeaturedCoupon(context, promo),
                           const SizedBox(height: 16),
                        ]
                      );
                    }
                    return Column(
                      children: [
                        _buildStandardCoupon(
                          context,
                          icon: CupertinoIcons.star_circle_fill,
                          type: 'Special Offer',
                          title: promo.title,
                          desc: promo.description,
                          code: promo.promoCode,
                          expiry: 'Expires: ${promo.expirationDate.split('T').first}',
                          isPrimary: true,
                        ),
                        const SizedBox(height: 16),
                      ],
                    );
                  }),
                  
                  const SizedBox(height: 80), // Bottom nav space
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedCoupon(BuildContext context, Promo promo) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
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
                  imageUrl: promo.bannerImageUrl,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Container(
                    height: 180,
                    width: double.infinity,
                    color: AppTheme.surfaceContainerHighest,
                    child: const Icon(CupertinoIcons.photo),
                  ),
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
                    Text('Special Harvest', style: TextStyle(color: AppTheme.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(promo.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(promo.description, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
                const SizedBox(height: 16),
                const Divider(height: 32, color: Colors.transparent), // Space for dashed line representation
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Code', style: TextStyle(color: AppTheme.outline, fontSize: 12)),
                        Text(promo.promoCode, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 2)),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () => _copyToClipboard(context, promo.promoCode),
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
            color: Colors.black.withValues(alpha: 0.04),
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
              IconButton(
                icon: const Icon(CupertinoIcons.doc_on_clipboard, color: AppTheme.primary),
                onPressed: () => _copyToClipboard(context, code),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _copyToClipboard(context, code);
              },
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
