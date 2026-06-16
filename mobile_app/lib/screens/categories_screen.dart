import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../theme/app_theme.dart';
import '../services/category_service.dart';
import 'category_products_screen.dart';

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
              Text('Explore Categories', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 8),
              Text('Freshness delivered from our fields to your kitchen.', style: TextStyle(color: AppTheme.onSurfaceVariant)),
              const SizedBox(height: 24),
              
              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(_filters.length, (index) {
                    return _buildFilterChip(_filters[index], _selectedFilterIndex == index, index);
                  }),
                ),
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
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      final category = categoryService.categories[index];
                      return _buildCategoryCard(context, category.name, '', category.image);
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
            color: isSelected ? AppTheme.primaryContainer : AppTheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppTheme.onPrimary : AppTheme.onSurfaceVariant,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, String subtitle, String imgUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => CategoryProductsScreen(categoryName: title)));
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
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
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
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(subtitle, style: TextStyle(color: AppTheme.outline, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }
}
