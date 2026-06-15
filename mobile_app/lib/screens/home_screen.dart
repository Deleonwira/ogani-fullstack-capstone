import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Custom App Bar
            SliverAppBar(
              floating: true,
              backgroundColor: AppTheme.surface,
              elevation: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.search, color: AppTheme.primary),
                    onPressed: () {},
                  ),
                  Text(
                    'Ogani',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  CircleAvatar(
                    backgroundImage: const CachedNetworkImageProvider(
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuB7y9gVZnT56NQd0X-WeBwRwhKp7NU2_a9liJSby69punCCNZs1t7TOBp9lEg7LyPetEv9rD6i-TwLuQhcDWgkrWZRIwKxc65QTV6Okg6udtbn1NQJA-Kn7v8jUI9Ck4eM2JF_J8fLYJowaPA7uQw-WRB6q_A_fDskB28aVbzj0NazdoFbWnRQi2-qCxHv9YTy7vYiUhAVx29qaBL2fNW-WoEnhJqBEDWW8u6aJYnhUOQIVjdh2jUEj0BgE2YiGUI7Xof5ICzZpb22F'),
                    radius: 16,
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80.0), // Padding for bottom nav
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _SearchField(),
                    const _CategoriesScroll(),
                    const _SpecialOffersCarousel(),
                    const _PopularProductsGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search for fresh produce...',
            hintStyle: TextStyle(color: AppTheme.outline),
            prefixIcon: const Icon(CupertinoIcons.search, color: AppTheme.primary),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          ),
        ),
      ),
    );
  }
}

class _CategoriesScroll extends StatelessWidget {
  const _CategoriesScroll();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Categories', style: Theme.of(context).textTheme.headlineMedium),
                TextButton(
                  onPressed: () {},
                  child: const Text('View All', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                _buildCategoryItem('Fruits', Icons.apple, true),
                _buildCategoryItem('Vegetables', Icons.eco, false),
                _buildCategoryItem('Dairy', Icons.egg, false),
                _buildCategoryItem('Meat', Icons.set_meal, false),
                _buildCategoryItem('Bakery', Icons.bakery_dining, false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String title, IconData icon, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: isActive ? AppTheme.primaryContainer.withOpacity(0.2) : AppTheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, size: 32, color: isActive ? AppTheme.primary : AppTheme.onSurfaceVariant),
          ),
          const SizedBox(height: 4),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _SpecialOffersCarousel extends StatelessWidget {
  const _SpecialOffersCarousel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
              image: const DecorationImage(
                image: CachedNetworkImageProvider(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuC749SMip_deDN_zfJmiSb-v0dJ5tZiB7jSRalTJrTLWt1hWgHC_hWrpW1tENECLrdoiqaRLmk6WWTG0kSCCIn4j52Bo-fy9RfHo_UPjMKBrykgkj5R_iBQt0Y4MKPSpsPzLyhASbz6x1Zvb_qV0dfwTxD8GF2Jf-xargJisYHLsHw_H75qr7BgH3JWg9jwWYgX9xkxuOe4yZgiZPBB7RsjvK4XMwT2rKja9QIWdtMgE8ZG50oZsWdZCDhwVIS09JRYxzTJrTfcbL2x'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'LIMITED TIME',
                      style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Fresh Greens\n30% OFF',
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, height: 1.2),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Sourced directly from local farms',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width: 24, height: 6, decoration: BoxDecoration(color: AppTheme.primary, borderRadius: BorderRadius.circular(3))),
              const SizedBox(width: 8),
              Container(width: 6, height: 6, decoration: BoxDecoration(color: AppTheme.outlineVariant, borderRadius: BorderRadius.circular(3))),
              const SizedBox(width: 8),
              Container(width: 6, height: 6, decoration: BoxDecoration(color: AppTheme.outlineVariant, borderRadius: BorderRadius.circular(3))),
            ],
          ),
        ],
      ),
    );
  }
}

class _PopularProductsGrid extends StatelessWidget {
  const _PopularProductsGrid();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Popular Products', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.7,
            children: [
              _buildProductCard(
                'Organic Pineapple',
                '1 unit (approx 1.2kg)',
                '\$4.99',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuCnnM-q7uyEBDu9JF9MBKY0mo8G4CiVxY8c3JRQCuE8SjwWIpgvnJxEAjycjHGPqJgHhMY2QFjvprq7DTEzFFpv4isTTD5TI-9Lb-MZ8jeltTd32z0dKvTZD0EKA1MmgqiKLTFNX_RADXPpZR6NEJkzFXGgFewHv5HmhJwVTM1Ah43irDzNL6_TUovqhdi4vkJR3YQboRSgdp3U-k27LYyvQoc7zLY_9Z0cBx9arD87ifnJP6BE9RHsmq72pulRJZrWWVkDoJc6fQeJ',
                isBestSeller: true,
              ),
              _buildProductCard(
                'Farm Fresh Eggs',
                '12 Eggs, Large',
                '\$5.25',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuA4t7QgzGc0oDMftzxlEhGKpDCVgRIWkKcf4GnaRIO9x3VqJ9dXUiGKycav-0_r-foHK6RkK1V_3sSggzOlvvOkTH4TiiSCNfTsldJH7mFbcOp3sCFcyD-mIQSh0HqqFyYA8ffQecISMx_BmbshkYVqiD6svoqQ8jQ5qGmj267baJL5JdA0Do17jzPSASYwivbqSFt3dDrHo5lySIimzHnu8gECoe3pLxM2C-alZlCJSD8eekG4IFvnurNz0VL7Ip_k-nnDlazxaYYR',
                oldPrice: '\$6.50',
                isDiscount: true,
              ),
              _buildProductCard(
                'Greek Yogurt',
                '500g, Plain Low Fat',
                '\$3.80',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAMalsFIvkA4JCzVPfEVjTk4YqMPCCVljZtVWbeQd_SQV0_kVLG7QD5k2Z3beFHJZep7s0XOqyoS4sEiWuEuUSz2hlVDwq50qDdXC3TLH7V2aAfEu6Mgfe9IywKBKjXpbASNPswaWby3He_j_Q8rAT4-GAEGz_mhrisVxCzwzV3_j_KIRNXLWJPcH5mSmQORZnJ8DTxXYtwx-eo1xbzkT8-LRHPR3u2HeRbbO8yX0CEaWdWKN-myWHpdWSOL91swdV21ilC7iElj5Op',
              ),
              _buildProductCard(
                'Mixed Salad Box',
                '250g, Pre-washed',
                '\$7.50',
                'https://lh3.googleusercontent.com/aida-public/AB6AXuAr2Tugzyj07nHOSYSNkDFUn08ymo9lAR9k-4VBAidviwoZbYXxtrZ3iUKJzyYt9fLq6WxWomWILVdHa3OMaOjFi84iepyjp0jPrxPd7A8xSOSaJpIQIdBFnQmprvUjkXbhOkheAcnZ-XnfaBnl22k1hvNh7KgCXO4ZTctD_FUcfG5-KHYODaBImQvkRyA4BeOZramI01wP-EoxdtT2Uupf7z-KmAyn0sMNtKYkr25n_sFo-EuOX3tln6kQ2BpQ28WZhA0Rgc_SQ1ju',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String name, String desc, String price, String imgUrl, {bool isBestSeller = false, String? oldPrice, bool isDiscount = false}) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.outlineVariant, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainerLow,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(imgUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (isBestSeller)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppTheme.secondaryContainer, borderRadius: BorderRadius.circular(4)),
                      child: const Text('Best Seller', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
              ],
            ),
          ),
          // Details
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(desc, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (oldPrice != null)
                          Text(oldPrice, style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: 10, color: AppTheme.onSurfaceVariant)),
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDiscount ? AppTheme.secondary : AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppTheme.secondary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(CupertinoIcons.add, color: Colors.white, size: 20),
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
