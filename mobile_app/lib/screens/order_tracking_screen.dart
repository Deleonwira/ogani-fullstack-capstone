import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../theme/app_theme.dart';
import '../models/order.dart';

class OrderTrackingScreen extends StatelessWidget {
  final Order? order;
  const OrderTrackingScreen({super.key, this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: Text(order != null ? 'Order #${order!.invoiceCode}' : 'Order Tracking', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.question_circle),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Map Area
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
                image: const DecorationImage(
                  image: CachedNetworkImageProvider(
                      'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&q=80&w=600&h=200'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  // Gradient overlay at bottom
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 80,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppTheme.surface.withValues(alpha: 0.8),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLowest,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Estimated Delivery', style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12)),
                          const SizedBox(height: 4),
                          const Text('12:45 PM', style: TextStyle(color: AppTheme.primary, fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Order Status Timeline
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Status', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 24),
                  _buildTimelineStep(
                    icon: CupertinoIcons.check_mark,
                    title: 'Order Placed',
                    subtitle: '10:00 AM, Today',
                    isActive: true,
                    isCompleted: true,
                  ),
                  _buildTimelineStep(
                    icon: CupertinoIcons.check_mark,
                    title: 'Packed & Ready',
                    subtitle: '11:15 AM, Today',
                    isActive: true,
                    isCompleted: true,
                  ),
                  _buildTimelineStep(
                    icon: CupertinoIcons.car_detailed,
                    title: 'In Transit',
                    subtitle: 'Driver is heading your way.',
                    isActive: true,
                    isCompleted: false,
                    isCurrent: true,
                  ),
                  _buildTimelineStep(
                    icon: CupertinoIcons.home,
                    title: 'Delivered',
                    subtitle: 'Pending',
                    isActive: order?.orderStatus == 'completed',
                    isCompleted: order?.orderStatus == 'completed',
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Order Items
            if (order != null && order!.orderDetails.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceContainerLowest,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.outlineVariant, width: 1.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Items in Order', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: order!.orderDetails.length,
                      separatorBuilder: (context, index) => const Divider(height: 24),
                      itemBuilder: (context, index) {
                        final item = order!.orderDetails[index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(item.product?.imageUrl ?? 'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&q=80&w=600&h=200'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.product?.name ?? 'Product', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 4),
                                  Text('Qty: ${item.quantity}', style: const TextStyle(color: AppTheme.onSurfaceVariant)),
                                ],
                              ),
                            ),
                            Text('Rp ${item.subtotal.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primary, fontSize: 16)),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            if (order != null && order!.orderDetails.isNotEmpty)
              const SizedBox(height: 24),

            // Delivery Agent Info
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.outlineVariant, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('YOUR DELIVERY AGENT', style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.surfaceContainerLow, width: 2),
                          image: const DecorationImage(
                            image: CachedNetworkImageProvider('https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&q=80&w=600&h=200'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Marcus Johnson', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(CupertinoIcons.star_fill, size: 14, color: AppTheme.tertiaryContainer),
                                const SizedBox(width: 4),
                                const Text('4.9', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                const SizedBox(width: 4),
                                Text('(120+ deliveries)', style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppTheme.primaryContainer.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(CupertinoIcons.phone_fill, color: AppTheme.primary),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Order Summary Snippet
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.outlineVariant, width: 1.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('ORDER', style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryContainer.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(order?.orderStatus.toUpperCase() ?? 'PENDING', style: const TextStyle(color: AppTheme.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 48,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              child: _buildOverlapAvatar('https://i.pravatar.cc/150?img=12'),
                            ),
                            Positioned(
                              left: 30,
                              child: _buildOverlapAvatar('https://i.pravatar.cc/150?img=13'),
                            ),
                            Positioned(
                              left: 60,
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceVariant,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: AppTheme.surfaceContainerLowest, width: 2),
                                ),
                                child: const Center(
                                  child: Text('+3', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.onSurfaceVariant)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text('Rp ${order?.totalPrice.toStringAsFixed(0) ?? "42500"}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOverlapAvatar(String imageUrl) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppTheme.surfaceContainerLowest, width: 2),
        image: DecorationImage(
          image: CachedNetworkImageProvider(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildTimelineStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isActive,
    required bool isCompleted,
    bool isCurrent = false,
    bool isLast = false,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isCompleted ? AppTheme.primaryContainer : (isCurrent ? AppTheme.primary : AppTheme.surfaceVariant),
                    shape: BoxShape.circle,
                    border: Border.all(color: isCurrent ? AppTheme.primary.withValues(alpha: 0.2) : Colors.transparent, width: 4),
                  ),
                  child: Icon(icon, size: 12, color: isActive ? Colors.white : AppTheme.onSurfaceVariant),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isCompleted ? AppTheme.primaryContainer.withValues(alpha: 0.3) : Colors.transparent,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: isCurrent ? AppTheme.primary : (isActive ? AppTheme.onSurface : AppTheme.onSurfaceVariant))),
                  const SizedBox(height: 4),
                  Text(subtitle, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
