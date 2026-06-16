import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../theme/app_theme.dart';
import 'order_tracking_screen.dart';
import 'notifications_screen.dart';
import 'auth/edit_profile_screen.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'auth/login_screen.dart';
import 'order_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    final String fullName = user?['fullName'] ?? 'John Doe';
    final String email = user?['email'] ?? 'john.doe@ogani.com';
    
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Ogani', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.search),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Opening Search...')));
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: const CachedNetworkImageProvider(
                  'https://i.pravatar.cc/150?img=11'),
              radius: 16,
            ),
          ),
        ],
      ),
      body: !authProvider.isAuthenticated 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(CupertinoIcons.person_crop_circle_badge_xmark, size: 80, color: AppTheme.outlineVariant),
                const SizedBox(height: 16),
                Text('Please login to view Profile', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                  child: const Text('Login / Register'),
                ),
              ],
            ),
          )
        : SingleChildScrollView(
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
                        image: CachedNetworkImageProvider('https://i.pravatar.cc/150?img=11'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: AppTheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(CupertinoIcons.pencil, size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(fullName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(email, style: const TextStyle(color: AppTheme.onSurfaceVariant)),
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
            _buildMenuItem(context, CupertinoIcons.cart, 'My Orders', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderTrackingScreen()));
            }),
            const SizedBox(height: 8),
            _buildMenuItem(context, CupertinoIcons.location_solid, 'Saved Addresses', onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Navigating to Saved Addresses...')));
            }),
            const SizedBox(height: 8),
            _buildMenuItem(context, CupertinoIcons.creditcard, 'Payment Methods', onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Navigating to Payment Methods...')));
            }),
            const SizedBox(height: 8),
            _buildMenuItem(context, CupertinoIcons.bell_solid, 'Notifications', hasBadge: true, onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationsScreen()));
            }),
            const SizedBox(height: 8),
            _buildMenuItem(context, CupertinoIcons.question_circle, 'Help Center', onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Navigating to Help Center...')));
            }),
            
            const SizedBox(height: 48),
            
            // Logout
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Logout'),
                        content: const Text('Are you sure you want to logout?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Close dialog
                              authProvider.logout();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Successfully logged out.')),
                              );
                            },
                            child: const Text('Logout', style: TextStyle(color: AppTheme.error)),
                          ),
                        ],
                      );
                    },
                  );
                },
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
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.outlineVariant.withValues(alpha: 0.5), width: 1),
      ),
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.primary)),
          Text(label, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String label, {bool hasBadge = false, VoidCallback? onTap}) {
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
        onTap: onTap,
      ),
    );
  }
}
