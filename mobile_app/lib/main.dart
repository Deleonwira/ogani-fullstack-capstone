import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'widgets/bottom_nav.dart';
import 'screens/home_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/profile_screen.dart';
import 'providers/cart_provider.dart';
import 'providers/auth_provider.dart';
import 'services/product_service.dart';
import 'services/promo_service.dart';
import 'services/category_service.dart';
import 'services/review_service.dart';
import 'services/order_service.dart';
import 'services/wishlist_service.dart';
import 'services/notification_service.dart';
import 'screens/auth/login_screen.dart';

// AppState to control global UI state like navigation
class AppState extends ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setTabIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductService()..fetchProducts()),
        ChangeNotifierProvider(create: (_) => PromoService()..fetchPromos()),
        ChangeNotifierProvider(create: (_) => CategoryService()..fetchCategories()),
        ChangeNotifierProvider(create: (_) => ReviewService()..fetchReviews()),
        ChangeNotifierProvider(create: (_) => OrderService()),
        ChangeNotifierProxyProvider<AuthProvider, WishlistService>(
          create: (context) => WishlistService(authProvider: Provider.of<AuthProvider>(context, listen: false)),
          update: (context, auth, previous) => previous ?? WishlistService(authProvider: auth)..fetchWishlist(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, NotificationService>(
          create: (context) => NotificationService(authProvider: Provider.of<AuthProvider>(context, listen: false)),
          update: (context, auth, previous) => previous ?? NotificationService(authProvider: auth)..fetchNotifications(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, _) {
        if (auth.isLoading) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        return MaterialApp(
          title: 'Ogani',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const MainLayout(),
        );
      },
    );
  }
}

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    
    return Scaffold(
      body: _screens[appState.currentIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: appState.currentIndex,
        onTap: (index) {
          appState.setTabIndex(index);
        },
      ),
    );
  }
}
