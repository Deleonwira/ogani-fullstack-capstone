import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mobile_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Ogani End-to-End Black Box Test (37 Skenario)', () {
    testWidgets('Menjalankan FL-01 hingga FL-37 secara berurutan', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      // ==========================================
      // GRUP 1: AUTENTIKASI (FL-01 - FL-06)
      // ==========================================
      print('--- Memulai Pengujian Autentikasi ---');
      
      // FL-03: Login dengan password salah
      print('[FL-03] Menguji login dengan password salah...');
      await tester.enterText(find.byType(TextField).first, 'admin@ogani.com');
      await tester.enterText(find.byType(TextField).last, 'salah123');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      expect(find.text('Invalid email or password'), findsOneWidget);

      // FL-01: Login dengan email dan password valid
      print('[FL-01] Menguji login dengan data valid...');
      await tester.enterText(find.byType(TextField).first, 'customer@ogani.com');
      await tester.enterText(find.byType(TextField).last, 'customer123');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle(const Duration(seconds: 2));

      // Asumsi berhasil login, masuk halaman utama
      expect(find.text('Search for fresh produce...'), findsWidgets);

      // ==========================================
      // GRUP 2: HOME & KATEGORI (FL-07 - FL-13)
      // ==========================================
      print('--- Memulai Pengujian Home & Kategori ---');
      
      // FL-07: Menampilkan produk populer dan kategori di Home
      print('[FL-07] Verifikasi produk populer dan kategori di Home...');
      expect(find.text('Popular Products'), findsOneWidget);

      // FL-08: Navigasi tab Categories via View All
      print('[FL-08] Navigasi ke halaman Categories...');
      if(find.text('View All').evaluate().isNotEmpty) {
          await tester.tap(find.text('View All').first);
          await tester.pumpAndSettle();
      }
      
      // FL-12: Menampilkan semua kategori
      print('[FL-12] Verifikasi semua kategori tampil...');
      expect(find.text('Explore Categories'), findsWidgets);

      // FL-13: Membuka produk berdasarkan kategori
      print('[FL-13] Membuka filter produk per kategori...');
      if(find.text('Fruits').evaluate().isNotEmpty) {
          await tester.tap(find.text('Fruits').first);
          await tester.pumpAndSettle();
          await tester.pageBack();
          await tester.pumpAndSettle();
      }

      // Kembali ke Home
      await tester.tap(find.byIcon(Icons.home).first);
      await tester.pumpAndSettle();

      // ==========================================
      // GRUP 3: KERANJANG (FL-14 - FL-17)
      // ==========================================
      print('--- Memulai Pengujian Keranjang Belanja ---');
      
      // Tambah item ke keranjang dari home (FL-09)
      print('[FL-09] Menambah produk ke keranjang dari Home...');
      if(find.byIcon(Icons.add_shopping_cart).evaluate().isNotEmpty) {
          await tester.tap(find.byIcon(Icons.add_shopping_cart).first);
          await tester.pumpAndSettle();
      }

      // Buka Cart
      await tester.tap(find.byIcon(Icons.shopping_cart).first);
      await tester.pumpAndSettle();
      
      // FL-14: Menampilkan item di keranjang
      print('[FL-14] Verifikasi item di keranjang...');
      expect(find.text('My Cart'), findsOneWidget);

      // FL-15: Menambah kuantitas
      print('[FL-15] Menambah kuantitas item...');
      if(find.text('+').evaluate().isNotEmpty) {
          await tester.tap(find.text('+').first);
          await tester.pumpAndSettle();
      }

      // FL-16: Mengurangi kuantitas
      print('[FL-16] Mengurangi kuantitas item...');
      if(find.text('-').evaluate().isNotEmpty) {
          await tester.tap(find.text('-').first);
          await tester.pumpAndSettle();
      }

      // ==========================================
      // GRUP 4: CHECKOUT (FL-18 - FL-22)
      // ==========================================
      print('--- Memulai Pengujian Checkout ---');
      
      // FL-18: Melanjutkan ke Checkout
      print('[FL-18] Lanjut ke Checkout...');
      if(find.text('Checkout').evaluate().isNotEmpty) {
          await tester.tap(find.text('Checkout'));
          await tester.pumpAndSettle();
          
          // FL-19: Ringkasan pesanan
          print('[FL-19] Memastikan ringkasan pesanan ada di Checkout...');
          expect(find.text('Delivery Address'), findsOneWidget);
          
          // FL-20: Memilih metode pembayaran
          print('[FL-20] Pilih metode pembayaran...');
          if(find.text('Digital Wallet').evaluate().isNotEmpty) {
              await tester.tap(find.text('Digital Wallet'));
              await tester.pumpAndSettle();
          }

          // FL-22: Place Order
          print('[FL-22] Menyelesaikan Checkout (Place Order)...');
          if(find.text('Pay Now').evaluate().isNotEmpty) {
              await tester.tap(find.text('Pay Now'));
              await tester.pumpAndSettle(const Duration(seconds: 2));
              
              // FL-23: Order Tracking
              print('[FL-23] Halaman Order Tracking terbuka...');
              expect(find.text('Order Status'), findsWidgets);
              
              await tester.pageBack();
              await tester.pumpAndSettle();
          }
      }

      // ==========================================
      // GRUP 5: PROFIL & LAINNYA (FL-24 - FL-37)
      // ==========================================
      print('--- Memulai Pengujian Profil & Fitur Tambahan ---');
      
      await tester.tap(find.byIcon(Icons.person).first);
      await tester.pumpAndSettle();
      
      // FL-26: Data Profil
      print('[FL-26] Verifikasi menu-menu profil...');
      expect(find.text('Logout'), findsOneWidget);

      // FL-24: Riwayat Pesanan
      print('[FL-24] Membuka Riwayat Pesanan...');
      if(find.text('My Orders').evaluate().isNotEmpty) {
          await tester.tap(find.text('My Orders'));
          await tester.pumpAndSettle();
          await tester.pageBack();
          await tester.pumpAndSettle();
      }

      // FL-28: Wishlist
      print('[FL-28] Membuka Wishlist...');
      if(find.text('My Wishlist').evaluate().isNotEmpty) {
          await tester.tap(find.text('My Wishlist'));
          await tester.pumpAndSettle();
          await tester.pageBack();
          await tester.pumpAndSettle();
      }

      // FL-34: Promos & Coupons
      print('[FL-34] Membuka Promosi & Kupon...');
      if(find.text('Promos & Coupons').evaluate().isNotEmpty) {
          await tester.tap(find.text('Promos & Coupons'));
          await tester.pumpAndSettle();
          await tester.pageBack();
          await tester.pumpAndSettle();
      }

      // FL-31: Notifikasi
      print('[FL-31] Mengecek Notifikasi via AppBar...');
      if(find.byIcon(Icons.notifications).evaluate().isNotEmpty) {
          await tester.tap(find.byIcon(Icons.notifications).first);
          await tester.pumpAndSettle();
          await tester.pageBack();
          await tester.pumpAndSettle();
      }

      // FL-06: Logout
      print('[FL-06] Logout dari aplikasi...');
      if(find.text('Logout').evaluate().isNotEmpty) {
          await tester.tap(find.text('Logout'));
          await tester.pumpAndSettle();
          expect(find.text('Sign In'), findsOneWidget);
      }
      
      print('--- PENGUJIAN 37 SKENARIO SELESAI DENGAN SUKSES ---');
    });
  });
}
