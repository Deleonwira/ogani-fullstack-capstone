import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../models/cart_item.dart';
import '../services/review_service.dart';

class ReviewsScreen extends StatelessWidget {
  final Product product;

  const ReviewsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Reviews & Ratings', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Info Context
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: product.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(product.description, style: const TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Rating Summary Bento Box
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Row(
                    children: [
                      // Average Score
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            const Text('4.8', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) => Icon(
                                index == 4 ? CupertinoIcons.star_lefthalf_fill : CupertinoIcons.star_fill,
                                color: AppTheme.tertiaryFixedDim,
                                size: 16,
                              )),
                            ),
                            const SizedBox(height: 8),
                            const Text('Based on 124 reviews', style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12), textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 100, color: AppTheme.outlineVariant.withValues(alpha: 0.3)),
                      const SizedBox(width: 16),
                      // Breakdown Bars
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            _buildRatingBar(5, 80, 98),
                            _buildRatingBar(4, 15, 18),
                            _buildRatingBar(3, 5, 6),
                            _buildRatingBar(2, 2, 2),
                            _buildRatingBar(1, 0, 0),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Actions & Filters
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.pencil_outline),
                    label: const Text('Write a Review'),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLowest,
                    border: Border.all(color: AppTheme.outlineVariant),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    children: [
                      Text('Sort by: ', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                      Text('Most Helpful', style: TextStyle(fontWeight: FontWeight.bold)),
                      Icon(CupertinoIcons.chevron_down, size: 16),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Reviews List
            Consumer<ReviewService>(
              builder: (context, reviewService, child) {
                if (reviewService.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final productReviews = reviewService.getReviewsForProduct(product.id);

                if (productReviews.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Text('No reviews yet. Be the first to review!'),
                    ),
                  );
                }

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: productReviews.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final review = productReviews[index];
                    return _buildReviewCard(
                      name: review.userName,
                      time: review.date.split('T').first, // Format date string
                      rating: review.rating,
                      title: review.title,
                      content: review.content,
                      helpful: 0,
                      avatarText: review.userName.isNotEmpty ? review.userName[0].toUpperCase() : 'A',
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingBar(int star, int percent, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Row(
              children: [
                Text('$star', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                const SizedBox(width: 2),
                const Icon(CupertinoIcons.star_fill, size: 10, color: AppTheme.tertiaryFixedDim),
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 8,
              decoration: BoxDecoration(color: AppTheme.surfaceVariant, borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: [
                  Container(
                    width: (percent / 100) * 120, // rough fixed width for now or use FractionallySizedBox
                    decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(4)),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 24,
            child: Text('$count', style: const TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12), textAlign: TextAlign.right),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard({
    required String name,
    required String time,
    required int rating,
    required String title,
    required String content,
    required int helpful,
    String? imageUrl,
    String? avatarText,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl != null)
                CircleAvatar(backgroundImage: CachedNetworkImageProvider(imageUrl), radius: 20)
              else if (avatarText != null)
                CircleAvatar(backgroundColor: AppTheme.secondaryContainer, foregroundColor: AppTheme.onSecondaryContainer, radius: 20, child: Text(avatarText)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(time, style: const TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12)),
                  ],
                ),
              ),
              Row(
                children: List.generate(5, (index) => Icon(
                  index < rating ? CupertinoIcons.star_fill : CupertinoIcons.star,
                  color: AppTheme.tertiaryFixedDim,
                  size: 14,
                )),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 4),
          Text(content, style: const TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14, height: 1.5)),
          const SizedBox(height: 12),
          Row(
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.hand_thumbsup, size: 16),
                label: Text('Helpful ($helpful)', style: const TextStyle(fontSize: 12)),
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.onSurfaceVariant,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.hand_thumbsdown, size: 16),
                color: AppTheme.onSurfaceVariant,
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
