import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mobile_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Ogani End-to-End Integration Test', () {
    testWidgets('Full User Journey (FL-01 to FL-37)', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // ==========================================
      // 1. AUTENTIKASI (FL-01 - FL-06)
      // ==========================================
      // Pastikan berada di halaman Login
      expect(find.text('Sign In'), findsOneWidget);

      // Coba login salah (FL-03)
      await tester.enterText(find.byType(TextField).first, 'customer@ogani.com');
      await tester.enterText(find.byType(TextField).last, 'salah123');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      expect(find.text('Invalid email or password'), findsOneWidget);

      // Login sukses (FL-01)
      await tester.enterText(find.byType(TextField).first, 'customer@ogani.com');
      await tester.enterText(find.byType(TextField).last, 'customer123');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      // ==========================================
      // 2. HALAMAN HOME & CATEGORIES (FL-07 - FL-13)
      // ==========================================
      // Pastikan masuk ke Home
      expect(find.text('Search for fresh produce...'), findsOneWidget);
      
      // Gulir untuk menemukan produk populer (FL-07)
      expect(find.text('Popular Products'), findsOneWidget);

      // Klik salah satu produk untuk melihat detail (FL-36)
      // Asumsi ada produk bernama "Fresh Apples"
      if(find.text('Fresh Apples').evaluate().isNotEmpty) {
          await tester.tap(find.text('Fresh Apples').first);
          await tester.pumpAndSettle();
          
          // Berada di Product Detail (FL-36)
          expect(find.text('Product Details'), findsOneWidget);
          
          // Tambah ke keranjang dari detail (FL-09)
          await tester.tap(find.text('Add to Cart'));
          await tester.pumpAndSettle();
          
          // Tambah ke Wishlist (FL-10)
          await tester.tap(find.byIcon(Icons.favorite_border).first);
          await tester.pumpAndSettle();
          
          // Kembali ke Home
          await tester.pageBack();
          await tester.pumpAndSettle();
      }

      // Navigasi ke tab Categories (FL-08)
      await tester.tap(find.text('View All').first);
      await tester.pumpAndSettle();
      expect(find.text('Explore Categories'), findsOneWidget);

      // ==========================================
      // 3. KERANJANG BELANJA (FL-14 - FL-17)
      // ==========================================
      // Buka Cart dari Bottom Nav
      await tester.tap(find.byIcon(Icons.shopping_cart).first);
      await tester.pumpAndSettle();
      expect(find.text('My Cart'), findsOneWidget);

      // Pastikan item ada (FL-14)
      expect(find.text('Fresh Apples'), findsWidgets);

      // Tambah kuantitas (FL-15)
      await tester.tap(find.text('+').first);
      await tester.pumpAndSettle();

      // ==========================================
      // 4. CHECKOUT (FL-18 - FL-22)
      // ==========================================
      // Klik Checkout (FL-18)
      await tester.tap(find.text('Checkout'));
      await tester.pumpAndSettle();
      
      // Di halaman Checkout (FL-19)
      expect(find.text('Delivery Address'), findsOneWidget);
      
      // Pilih metode pembayaran (FL-20)
      await tester.tap(find.text('Digital Wallet'));
      await tester.pumpAndSettle();

      // Place Order (FL-22)
      await tester.tap(find.text('Pay Now'));
      await tester.pumpAndSettle();

      // ==========================================
      // 5. ORDER TRACKING & HISTORY (FL-23 - FL-25)
      // ==========================================
      // Setelah checkout, harusnya dialihkan ke Order Tracking
      expect(find.text('Order Tracking'), findsOneWidget);
      expect(find.text('Order Status'), findsOneWidget);

      // Kembali ke Home, lalu ke Profil
      await tester.pageBack();
      await tester.pumpAndSettle();

      // ==========================================
      // 6. PROFIL & LAINNYA (FL-26 - FL-37)
      // ==========================================
      // Tab Profile
      await tester.tap(find.byIcon(Icons.person).first);
      await tester.pumpAndSettle();
      
      // Buka Promos & Coupons (FL-34)
      await tester.tap(find.text('Promos & Coupons'));
      await tester.pumpAndSettle();
      expect(find.text('Discover fresh savings'), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Buka Notifikasi via AppBar (FL-31)
      await tester.tap(find.byIcon(Icons.notifications).first);
      await tester.pumpAndSettle();
      expect(find.text('Notifications'), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();

      // Logout (FL-06)
      await tester.tap(find.text('Logout'));
      await tester.pumpAndSettle();
      
      // Kembali ke halaman Login
      expect(find.text('Sign In'), findsOneWidget);
    });
  });
}
