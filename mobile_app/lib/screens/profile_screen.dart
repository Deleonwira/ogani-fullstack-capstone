import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuC2b1Y0OsI8uP2zB50FsxXySEuu2QTOb8jFaLWY3oGTsYlBRBZZ_lP3-rpR85cbukui80WrwSbwxtPpJl6-a3f6tu7mxiFbfqMSUhjELMOqC2W0pQ4LjWZdd9LCf_CzJMlKSqGrj51YP0-DUAmVh-cf9XJpxooK7nWlUJQO8Vebz1_60E8aycpaJMnCk1_UMPsFta0zYxMMHwUFpw7ZNr62G-FYP-PkGEcMSjVRpcALXiEQUrjw_CuHHZn3_Ay5jp6nfWtMaAAROAgK'),
              radius: 16,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Hero Profile Section
            const SizedBox(height: 24),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.primaryContainer, width: 4),
                      image: const DecorationImage(
                        image: CachedNetworkImageProvider('https://lh3.googleusercontent.com/aida-public/AB6AXuBS1CU51znLWR4xY_tm4eTZga0vjw_y4_vvDXanjZgSFXpWkNL6uyEdDFNeHrnu2ooIJDXkyTnZ4nNY8_C2MRXMTN5H_QC9JhYxUxjBjAhuuZY5AqTX8VF0uARDwPwNn63rXy301wA64JZSqhGykAykoSS1FCCSAKE_5WZfAoeX2PmZc0YKXG5qH5nEnPt1lzCAM8X6Xne7wYuC08-0at5WaVQoUW5sveUFA9rlM3up8-3qSWL7h4RHMq9EcRIh_GRIzI3fOjEn2EiX'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(CupertinoIcons.pencil, size: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text('John Doe', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('john.doe@ogani.com', style: TextStyle(color: AppTheme.onSurfaceVariant)),
            const SizedBox(height: 32),
            
            // Stats Grid
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('12', 'Orders'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard('2.4k', 'Points'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Menu List
            _buildMenuItem(CupertinoIcons.cart, 'My Orders'),
            const SizedBox(height: 8),
            _buildMenuItem(CupertinoIcons.location_solid, 'Saved Addresses'),
            const SizedBox(height: 8),
            _buildMenuItem(CupertinoIcons.creditcard, 'Payment Methods'),
            const SizedBox(height: 8),
            _buildMenuItem(CupertinoIcons.bell_solid, 'Notifications', hasBadge: true),
            const SizedBox(height: 8),
            _buildMenuItem(CupertinoIcons.question_circle, 'Help Center'),
            
            const SizedBox(height: 48),
            
            // Logout
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.square_arrow_right),
                label: const Text('Logout', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.error.withValues(alpha: 0.1),
                  foregroundColor: AppTheme.error,
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Version 2.4.0 (OganiBuild)', style: TextStyle(color: AppTheme.outlineVariant, fontSize: 12)),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.outlineVariant, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primary)),
          Text(label, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, {bool hasBadge = false}) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppTheme.primaryContainer.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppTheme.primary),
        ),
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (hasBadge)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(right: 8),
                decoration: const BoxDecoration(
                  color: AppTheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
              ),
            Icon(CupertinoIcons.chevron_right, color: AppTheme.outlineVariant),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
