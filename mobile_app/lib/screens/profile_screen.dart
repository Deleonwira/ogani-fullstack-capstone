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
import 'wishlist_screen.dart';
import 'promos_screen.dart';
import '../main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.user;
    final String fullName = user?['fullName'] ?? 'John Doe';
    final String email = user?['email'] ?? 'john.doe@ogani.com';
    final String avatarUrl = user?['avatarUrl'] ?? 'https://i.pravatar.cc/150?img=11';
    final String totalOrders = user?['totalOrders']?.toString() ?? '0';
    final String totalPoints = user?['totalPoints']?.toString() ?? '0';

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
              fit: BoxFit.contain,
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
              icon: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(avatarUrl),
                radius: 16,
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
      body: !authProvider.isAuthenticated
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    CupertinoIcons.person_crop_circle_badge_xmark,
                    size: 80,
                    color: AppTheme.outlineVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Please login to view Profile',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
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
                            border: Border.all(
                              color: AppTheme.outlineVariant,
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(avatarUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const EditProfileScreen(),
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppTheme.primary,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                CupertinoIcons.pencil,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    fullName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(color: AppTheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 32),

                  // Stats Grid
                  Row(
                    children: [
                      Expanded(child: _buildStatCard(totalOrders, 'Orders')),
                      const SizedBox(width: 16),
                      Expanded(child: _buildStatCard(totalPoints, 'Points')),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Menu List
                  _buildMenuItem(
                    context,
                    CupertinoIcons.cart,
                    'My Orders',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const OrderHistoryScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 8),
                  _buildMenuItem(
                    context,
                    CupertinoIcons.heart_fill,
                    'My Wishlist',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const WishlistScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildMenuItem(
                    context,
                    CupertinoIcons.ticket_fill,
                    'Promos & Offers',
                    hasBadge: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PromosScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildMenuItem(
                    context,
                    CupertinoIcons.bell_solid,
                    'Notifications',
                    hasBadge: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const NotificationsScreen(),
                        ),
                      );
                    },
                  ),


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
                              content: const Text(
                                'Are you sure you want to logout?',
                              ),
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
                                      const SnackBar(
                                        content: Text(
                                          'Successfully logged out.',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(color: AppTheme.error),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(CupertinoIcons.square_arrow_right),
                      label: const Text(
                        'Logout',
                        style: TextStyle(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.surfaceContainerLowest,
                        foregroundColor: AppTheme.error,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: AppTheme.error, width: 1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Version 2.4.0 (OganiBuild)',
                    style: TextStyle(
                      color: AppTheme.outlineVariant,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 120), // Extra padding for bottom nav bar
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
        border: Border.all(
          color: AppTheme.outlineVariant,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppTheme.primary,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String label, {
    bool hasBadge = false,
    VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.outlineVariant, width: 1.0),
      ),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.primary),
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
