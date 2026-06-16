import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../services/order_service.dart';
import 'order_tracking_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPaymentMethod = 0; // 0: Credit Card, 1: Digital Wallet, 2: Bank Transfer

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(
        title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Delivery Address
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(CupertinoIcons.car_detailed, color: AppTheme.primary),
                          const SizedBox(width: 8),
                          Text('Delivery Address', style: Theme.of(context).textTheme.headlineMedium),
                        ],
                      ),
                      TextButton(onPressed: () {}, child: const Text('Change')),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.secondaryContainer.withValues(alpha: 0.3),
                      border: Border.all(color: AppTheme.primaryContainer),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(CupertinoIcons.location_solid, color: AppTheme.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Home Address', style: TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text('123 Organic Lane, Fresh Garden Estate\nSan Francisco, CA 94103', style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
                              const SizedBox(height: 4),
                              Text('+1 (555) 000-1234', style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Payment Method
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(CupertinoIcons.money_dollar_circle_fill, color: AppTheme.primary),
                      const SizedBox(width: 8),
                      Text('Payment Method', style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildPaymentMethod(0, CupertinoIcons.creditcard, 'Credit Card')),
                      const SizedBox(width: 8),
                      Expanded(child: _buildPaymentMethod(1, CupertinoIcons.device_phone_portrait, 'Digital Wallet')),
                      const SizedBox(width: 8),
                      Expanded(child: _buildPaymentMethod(2, CupertinoIcons.building_2_fill, 'Bank Transfer')),
                    ],
                  ),
                  if (_selectedPaymentMethod == 0) ...[
                    const SizedBox(height: 24),
                    _buildTextField('Cardholder Name', 'John Doe'),
                    const SizedBox(height: 12),
                    _buildTextField('Card Number', '0000 0000 0000 0000', icon: CupertinoIcons.creditcard),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(child: _buildTextField('Expiry Date', 'MM/YY')),
                        const SizedBox(width: 12),
                        Expanded(child: _buildTextField('CVV', '123')),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Order Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order Summary', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                      Text('\$${cart.subtotalAmount.toStringAsFixed(2)}', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Fee', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                      Text('\$${cart.deliveryFee.toStringAsFixed(2)}', style: TextStyle(color: AppTheme.onSurfaceVariant)),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Divider(color: AppTheme.outlineVariant),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.primary)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80), // Space for bottom button
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.surfaceContainerLowest,
          border: Border(top: BorderSide(color: AppTheme.outlineVariant.withValues(alpha: 0.5), width: 1)),
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Consumer<OrderService>(
                  builder: (context, orderService, child) {
                    return ElevatedButton.icon(
                      onPressed: orderService.isLoading
                          ? null
                          : () async {
                              if (cart.items.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cart is empty')));
                                return;
                              }

                              final auth = Provider.of<AuthProvider>(context, listen: false);
                              final userId = auth.user?['userId'] as int?;
                              if (userId == null) {
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User not logged in')));
                                return;
                              }

                              final success = await orderService.createOrder(
                                userId: userId,
                                items: cart.items.values.toList(),
                                totalAmount: cart.totalAmount,
                                subtotalAmount: cart.subtotalAmount,
                                shippingCost: cart.deliveryFee,
                                shippingAddress: '123 Organic Lane, San Francisco, CA 94103',
                                receiverName: 'John Doe',
                                receiverPhone: '+1 (555) 000-1234',
                              );

                              if (success) {
                                cart.clear();
                                if (context.mounted) {
                                  Navigator.pushReplacement(
                                    context,
                                    // Will fix this order tracking navigation later
                                    MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
                                  );
                                }
                              } else {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Failed to create order')));
                                }
                              }
                            },
                      icon: orderService.isLoading
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Icon(CupertinoIcons.lock_fill, size: 18),
                      label: Text(orderService.isLoading ? 'Processing...' : 'Pay Now', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(int index, IconData icon, String label) {
    bool isSelected = _selectedPaymentMethod == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPaymentMethod = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.secondaryContainer.withValues(alpha: 0.3) : AppTheme.surfaceContainerLowest,
          border: Border.all(color: isSelected ? AppTheme.primaryContainer : AppTheme.outlineVariant),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? AppTheme.primary : AppTheme.onSurfaceVariant),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, {IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceBright,
            border: Border.all(color: AppTheme.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: AppTheme.outline),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: icon != null ? Icon(icon, color: AppTheme.onSurfaceVariant) : null,
            ),
          ),
        ),
      ],
    );
  }
}
