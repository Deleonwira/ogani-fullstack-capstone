import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../services/category_service.dart';
import 'category_products_screen.dart';
import 'notifications_screen.dart';
import '../main.dart';
import '../providers/auth_provider.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _selectedFilterIndex = 0;

  final List<String> _filters = [
    'All Essentials',
    'Seasonal',
    'Organic Only',
    'On Sale',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icons/app-logo.png',
              height: 38,
              width: 38,
              fit: BoxFit.fitHeight,
              errorBuilder: (context, error, stackTrace) => const Icon(
                CupertinoIcons.cart_fill,
                color: AppTheme.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: 8),
            const Text('Ogani', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),

        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.bell, color: AppTheme.primary),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: PopupMenuButton<String>(
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore Categories',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Freshness delivered from our fields to your kitchen.',
                style: TextStyle(color: AppTheme.onSurfaceVariant),
              ),
              const SizedBox(height: 24),



              // Grid
              Consumer<CategoryService>(
                builder: (context, categoryService, child) {
                  if (categoryService.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (categoryService.categories.isEmpty) {
                    return const Center(child: Text('No categories found.'));
                  }

                  return GridView.builder(
                    itemCount: categoryService.categories.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      final category = categoryService.categories[index];
                      return _buildCategoryCard(
                        context,
                        category.name,
                        '',
                        category.image,
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 80), // Space for bottom nav
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedFilterIndex = index;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.primaryContainer
                : AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected
                  ? AppTheme.onPrimary
                  : AppTheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    String subtitle,
    String imgUrl,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CategoryProductsScreen(categoryName: title),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppTheme.outlineVariant, width: 1.0),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: CachedNetworkImage(
                  imageUrl: imgUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: AppTheme.outline, fontSize: 12),
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
