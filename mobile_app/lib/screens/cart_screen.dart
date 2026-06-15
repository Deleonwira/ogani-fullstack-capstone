import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuCq3Fz86cR3f9YQdcau17Bpg6JWgfz1QAfQbEnhVm8pQQUS122oZL6hbp_VG8wdqkXZh7VxnQmmjWCqlqTUCTcJumVMufYhXe291XGGaerA4AnuJlEpgtdlsPUg0S3p_s6pjiCJHZYt1VTCZnOOELfjMq3oYYydU_6cdB1NQC3DYvWeSW9gF-7igplhEr2BYEK3eXf7Bk6h7MBMhRbiNV0UTN-POsUW5xRBILlmCYY5N_NBIi_760Shpo0HUnSjLJkrZBAfV8xQ6AX0'),
              radius: 16,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Cart', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  
                  _buildCartItem(
                    'Organic Gala Apples',
                    '2kg',
                    '\$5.50',
                    '1',
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDgk6YMOGrKOyGhUxdGxZIoBF8AxP_IZTw11brwlN_TC6goHxygaJmQYZDO6d65rW-sdqAvZr7BYpi5xPlS3c96UH_W7615ehTXJA6MT55h8RKRortTkCQDB-RJK8rR3Cp6yd9KYuGqRAFchkeK1iCCCgEPF28W5yuqmaRH4gHfdCDm0hRTM8Z407VtQs_MWw0l7JB2-jSGtgcYl8W5q1I10nfek7cbqRUMSLKR5FgZhk8Bgb9zydtYIxSiKX8N0QmasU3nPDFxUqoO',
                  ),
                  const SizedBox(height: 16),
                  _buildCartItem(
                    'Fresh Whole Milk',
                    '1L',
                    '\$3.75',
                    '1',
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBrTSrkUqYh_fzPT-lrw4pW7Br4FTfH5cuxS7J8d9sIGIE6LHtLtgJg4M7pvOuDn0iotZrNkwNnG7yuJ95XV_m92Z3t6CmfqYEHejMUtVF0iIXikx5jBUYrOOF8brg0jO4ep_BAGEOP_NfkYpkIoN8AM-au6HQmXwyYDqHymylcebB0BFtE7a5ZAssyIhdajJzSr9hI9i_Psygu5RPjd-C84xJxcAqtdVhLgW-gjejkDSs3op4FvqT2Dgy_RKPQO5e4_WYRXYwOLAHw',
                  ),
                  const SizedBox(height: 16),
                  _buildCartItem(
                    'Whole Grain Bread',
                    '1 loaf',
                    '\$4.20',
                    '1',
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuBLDK-iHjU6dBGImzwTbLo3m9py8Oe5Glg56nRNZVzL8WtWTrBWKgZAkhP5syxZClSw5hYLm7WCdtJSGf_frLWkKg6l2YTLSyzXZuvTmFzFTGfDJiG7xNFRKlgFmz9xu7ADaDrdgKvSxunSXMyNd25XYmFwBPwLh9bWlD17m0-gOrDTurqZxGx0eJXATl4fNuwfWhBJJABk8ZxQOmZlpX-ATzO53TKqx8tSwf-a1uHKMF008Oqlc6XA4gDZyUFZVwC4Jo_fzqf_YoQB',
                  ),
                ],
              ),
            ),
          ),
          
          // Checkout Bottom Section
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: AppTheme.surfaceContainerLowest,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 20,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                      Text('\$13.45', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Fee', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                      Text('\$2.00', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const Text('\$15.45', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
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

  Widget _buildCartItem(String name, String weight, String price, String qty, String imgUrl) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.outlineVariant, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: imgUrl,
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
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(weight, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.primary)),
                    Container(
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(CupertinoIcons.minus, size: 16, color: AppTheme.primary),
                            onPressed: () {},
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(),
                          ),
                          Text(qty, style: const TextStyle(fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(CupertinoIcons.add, size: 16, color: AppTheme.primary),
                            onPressed: () {},
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
