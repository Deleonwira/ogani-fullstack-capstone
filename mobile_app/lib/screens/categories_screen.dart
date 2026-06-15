import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

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
                  children: [
                    _buildFilterChip('All Essentials', true),
                    _buildFilterChip('Seasonal', false),
                    _buildFilterChip('Organic Only', false),
                    _buildFilterChip('On Sale', false),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
                children: [
                  _buildCategoryCard('Fruits', '120+ Items', 'https://lh3.googleusercontent.com/aida-public/AB6AXuATfJGRCDqPaAKbY6HwNATmUjmOD5Q_MQaQGnVAWBOx5mYaDjfYA_34wSpnB06A3y7O7HwjGgyK0Ue5vodddvnmrZFk8NzdAkWx89x6pm1qs6s_SFMBc7zXbFOJD3VurUVyOY8pu0s36rrijZO2XfcpiLgRiSS5GPm5c5FR7DEQN__GPec2VKjhl-5Q9oU-RcAF8TlRZfqNRJ0S0MHdbZxvgARIAL2jY8gP-u5csJ40-O4gmdLJSMlLRFbGkRVQy4M8kQ-m0jll5qBQ'),
                  _buildCategoryCard('Vegetables', '85+ Items', 'https://lh3.googleusercontent.com/aida-public/AB6AXuC4X-P6me6E_ytExUL0TpVHTSZRTXGiHzsCRO7Jb5krWhqaXOQlAZBTM1QInEr-NmCNCUz2PAsxjhPtdH5UzxtfSf6ikf0lCFi1a4WYvuFezxBsWMlFUqd3X8aTZmu3Z_Amd9QwoFi9t18GXUM2ZAHYWAsI_F_Z167oKgYXSPl-FSchIlFW8bmj5Zj7mtE5HZ7NGYsWoHB9qjkZMM1ZhccoRYSX9lEyPixveT8Kdw_7I_wgTbkuybPSV5Jav1UHUZL0GP-JDWXbz38S'),
                  _buildCategoryCard('Meat & Seafood', '60+ Items', 'https://lh3.googleusercontent.com/aida-public/AB6AXuBQUkFFTHRJHkYH4OxURJlj-fkbFYsuu_gRQAALxhcDzEUH6coZOtH5RrB8a4lnQwKNqOuZ38gBGQ37xKF2R3XdGfNaKg-BoQgDBvsVh5nlGOeXwjyWduSYvOqff8GqB2O_XpMpHyvOm-OQsPjBoP0FZtubSWVegOoXcf2SmH8GvfG5TMU5DC4zUPT89ChJFUk-CmV0CiAlavzm9hjRzEiPpaMdA76nsCzk37dk-hwjggUVFghQ-6SoJSmJvUk-3Jc7HSVGb-PijXFF'),
                  _buildCategoryCard('Dairy & Eggs', '45+ Items', 'https://lh3.googleusercontent.com/aida-public/AB6AXuAlowNdCoxjpGIs0lZIy7tko-HPfSUvY2x6Bqih-GdLcD2U9k-sPWkcjyz7DU-wPuQfxzrSbem41sEeKazhHVlQGkc4fTcOXqsIpJ1JT2C2aS2BrM4cAV1hGX3-2sonpcsKtkZXQf8tp7GX7xu-qGHMaUenpADXrWnB2BohFHLijaI1qCiXKK08UMcSrtLP-PU76SDcAbaTqSRjcPt2AARh9-5JFySIqWpeYO5p4wz_5mgI93POk132ntacQIL2vR1OhFOilb4yn850'),
                  _buildCategoryCard('Bakery', '30+ Items', 'https://lh3.googleusercontent.com/aida-public/AB6AXuCwS-SEGeQNm2FKTnmDMBPZt04nTtR_Hnmge8o4Qt6aJ_lbG7oCEtqBMUmIzSKGmIbom7UWTNBd6CjUVt7ivtiMIf47BW5KQ95a6oqXPdys-TjPR2K1A0dcphffUPJ84SHpiDmRINhdXyYmaK16tOIyriYDfpxduAlYT2NSs6fZODmjakLN6sr9EIeWtBd-S7Gm0iIGLAGdJ34uoceMP31FtuWhkBoCsvrBVzV89e0pvUABl68fBwEflXpicJwg5pFYEg8Ixgvd9N4A'),
                  _buildCategoryCard('Pantry', '200+ Items', 'https://lh3.googleusercontent.com/aida-public/AB6AXuBxqFUbbFcz8YO0uNtTidltXBdiaUmTeNnqOSPTmVFAyaqbvT-EUR-6CvYJ4PBmIsl1PahanjB-y6KI7GGqqvcNAXi_eDl3BDhLIksgCinA6-OgG3Hez-4MzqIhjXTXXEvowjCcFNUId_aBIHN9ZRPpEy9yMRhV_BwqhGjyMQmCX99M25p2roBxLdai141UfcDtHt5_LHm-g80VQGR6ksTdV4F0ugjFUn8rjz0ReSqz1nhBli2ZBbp2_6zhAWRkp4X2eP1VIt-lwp1e'),
                ],
              ),
              const SizedBox(height: 80), // Space for bottom nav
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
    );
  }

  Widget _buildCategoryCard(String title, String subtitle, String imgUrl) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
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
    );
  }
}
