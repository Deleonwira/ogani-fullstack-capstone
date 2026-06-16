import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';
import '../main.dart'; // For AppState
import '../services/product_service.dart';
import '../services/promo_service.dart';
import '../providers/auth_provider.dart';
import '../services/category_service.dart';
import '../services/wishlist_service.dart';
import 'product_detail_screen.dart';
import 'category_products_screen.dart';
import 'auth/login_screen.dart';
import 'notifications_screen.dart';

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
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset('assets/icons/app-logo.png', height: 48, width: 48, fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(CupertinoIcons.cart_fill, color: AppTheme.primary, size: 28),
                    ),
                  ),
                  Text(
                    'Ogani',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(CupertinoIcons.bell, color: AppTheme.primary),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
                        },
                      ),
                      PopupMenuButton<String>(
                        offset: const Offset(0, 45),
                        padding: EdgeInsets.zero,
                        icon: Consumer<AuthProvider>(
                          builder: (context, auth, child) => CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                                auth.user?['avatarUrl'] ?? 'https://i.pravatar.cc/150?img=11'),
                            radius: 16,
                          ),
                        ),
                        onSelected: (value) {
                          if (value == 'profile') {
                            Provider.of<AppState>(context, listen: false).setTabIndex(3);
                          } else if (value == 'logout') {
                            Provider.of<AuthProvider>(context, listen: false).logout();
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'profile',
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.person, size: 20),
                                SizedBox(width: 12),
                                Text('Profile'),
                              ],
                            ),
                          ),
                          const PopupMenuItem<String>(
                            value: 'logout',
                            child: Row(
                              children: [
                                Icon(CupertinoIcons.square_arrow_right, size: 20),
                                SizedBox(width: 12),
                                Text('Logout'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80.0), // Padding for bottom nav
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _SearchField(),
                    _SpecialOffersCarousel(),
                    _CategoriesScroll(),
                    _PopularProductsGrid(),
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
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for fresh produce...',
          prefixIcon: Icon(CupertinoIcons.search),
        ),
      ),
    );
  }
}

class _CategoriesScroll extends StatelessWidget {
  const _CategoriesScroll();

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryService>(
      builder: (context, categoryService, child) {
        if (categoryService.isLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final categories = categoryService.categories;
        if (categories.isEmpty) {
          return const SizedBox.shrink();
        }

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
                    Text('Shop by Category', style: Theme.of(context).textTheme.headlineMedium),
                    TextButton(
                      onPressed: () {
                        // Navigate to categories tab
                        Provider.of<AppState>(context, listen: false).setTabIndex(1);
                      },
                      child: const Text('View All', style: TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  children: [
                    ...categories.map((category) {
                      return _buildCategoryCard(context, category.name, category.image);
                    }),
                    _buildAllCategoriesCard(context),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String imgUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryProductsScreen(categoryName: title),
          ),
        );
      },
      child: SizedBox(
        width: 80,
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.outlineVariant, width: 1.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15), // Slightly smaller than container to fit inside border
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAllCategoriesCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<AppState>(context, listen: false).setTabIndex(1);
      },
      child: SizedBox(
        width: 80,
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.outlineVariant, width: 1.0),
              ),
              child: const Center(
                child: Icon(CupertinoIcons.square_grid_2x2, color: AppTheme.primary, size: 32),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'All Categories',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _SpecialOffersCarousel extends StatefulWidget {
  const _SpecialOffersCarousel();

  @override
  State<_SpecialOffersCarousel> createState() => _SpecialOffersCarouselState();
}

class _SpecialOffersCarouselState extends State<_SpecialOffersCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_pageController.hasClients) {
        // Use Consumer's promoService length (we'll fetch it inside the build safely, but here we can just animate blindly and wrap around by listening to page changes)
        // Wait, better to just let it scroll to page + 1, and in the builder we can use `index % promos.length` for infinite scroll.
        _pageController.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PromoService>(
      builder: (context, promoService, child) {
        if (promoService.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final promos = promoService.promos;
        if (promos.isEmpty) {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page % promos.length;
                    });
                  },
                  itemBuilder: (context, index) {
                    final promo = promos[index % promos.length];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(promo.bannerImageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            colors: [Colors.black.withValues(alpha: 0.6), Colors.transparent],
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
                            Text(
                              promo.title,
                              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold, height: 1.2),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              promo.description,
                              style: const TextStyle(color: Colors.white70, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  promos.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _currentPage == index ? AppTheme.primary : AppTheme.outlineVariant,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PopularProductsGrid extends StatelessWidget {
  const _PopularProductsGrid();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductService>(
      builder: (context, productService, child) {
        if (productService.isLoading) {
          return const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final products = productService.products.take(6).toList(); // Show top 6

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Popular Products', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 16),
              if (products.isEmpty)
                const Text('No products available.', style: TextStyle(color: AppTheme.onSurfaceVariant))
              else
                GridView.builder(
                  itemCount: products.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                  ),
                  itemBuilder: (context, index) {
                    return _buildProductCard(context, products[index]);
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product)));
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.outlineVariant, width: 1.0),
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
                      image: CachedNetworkImageProvider(product.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (product.isBestSeller)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppTheme.secondaryContainer, borderRadius: BorderRadius.circular(4)),
                      child: const Text('Best Seller', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Consumer<WishlistService>(
                    builder: (context, wishlistService, child) {
                      final isWishlisted = wishlistService.wishlistItems.any((item) => item.id == product.id);
                      return GestureDetector(
                        onTap: () {
                          final auth = Provider.of<AuthProvider>(context, listen: false);
                          if (!auth.isAuthenticated) {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                            return;
                          }
                          if (isWishlisted) {
                            wishlistService.removeFromWishlist(product.id);
                          } else {
                            wishlistService.addToWishlist(product.id);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.8),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isWishlisted ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                            color: isWishlisted ? Colors.red : AppTheme.onSurfaceVariant,
                            size: 16,
                          ),
                        ),
                      );
                    },
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
                Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(product.description, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.oldPrice != null)
                          Text(product.oldPrice!, style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: 10, color: AppTheme.onSurfaceVariant)),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: product.isDiscount ? AppTheme.secondary : AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        final auth = Provider.of<AuthProvider>(context, listen: false);
                        if (!auth.isAuthenticated) {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                          return;
                        }
                        
                        // Add to Cart
                        Provider.of<CartProvider>(context, listen: false).addItem(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} added to cart'),
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                              label: 'VIEW CART',
                              onPressed: () {
                                Provider.of<AppState>(context, listen: false).setTabIndex(2);
                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppTheme.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(CupertinoIcons.add, color: Colors.white, size: 20),
                      ),
                    ),
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
}
