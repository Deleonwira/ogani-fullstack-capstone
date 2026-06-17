import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../theme/app_theme.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../services/order_service.dart';
import '../services/notification_service.dart';
import 'order_tracking_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPaymentMethod = 0; // 0: Credit Card, 1: Digital Wallet, 2: Bank Transfer

  final TextEditingController _promoController = TextEditingController();
  bool _isApplyingPromo = false;

  // Address State
  String _addressName = '';
  String _addressDetail = '';
  String _addressPhone = '';

  @override
  void initState() {
    super.initState();
    // Initialize address with actual user profile data instead of mock
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    if (user != null) {
      _addressName = user['fullName'] ?? 'My Name';
      _addressDetail = user['address'] ?? 'Please set your address';
      _addressPhone = user['phoneNumber'] ?? 'Please set your phone number';
    }
  }

  void _showEditAddressDialog() {
    final nameController = TextEditingController(text: _addressName);
    final detailController = TextEditingController(text: _addressDetail);
    final phoneController = TextEditingController(text: _addressPhone);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Delivery Address'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Address Name (e.g. Home, Office)'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: detailController,
                  decoration: const InputDecoration(labelText: 'Full Address'),
                  maxLines: 3,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _addressName = nameController.text.isNotEmpty ? nameController.text : _addressName;
                  _addressDetail = detailController.text.isNotEmpty ? detailController.text : _addressDetail;
                  _addressPhone = phoneController.text.isNotEmpty ? phoneController.text : _addressPhone;
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  Future<void> _applyPromo(CartProvider cart) async {
    setState(() => _isApplyingPromo = true);
    final error = await cart.applyPromoCode(_promoController.text.trim());
    
    if (!mounted) return;
    setState(() => _isApplyingPromo = false);
    
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error), backgroundColor: AppTheme.error));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Promo code applied successfully!')));
      _promoController.clear();
    }
  }

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
                      TextButton(
                        onPressed: _showEditAddressDialog,
                        child: const Text('Change'),
                      ),
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
                              Text(_addressName, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(_addressDetail, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 14)),
                              const SizedBox(height: 4),
                              Text(_addressPhone, style: TextStyle(color: AppTheme.onSurfaceVariant, fontSize: 12)),
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

            // Promo Code Section
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
                      Icon(CupertinoIcons.ticket_fill, color: AppTheme.primary),
                      const SizedBox(width: 8),
                      Text('Promo Code', style: Theme.of(context).textTheme.headlineMedium),
                    ],
                  ),
                  const SizedBox(height: 16),
                  if (cart.appliedPromo != null)
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cart.appliedPromo!.title,
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                                ),
                                Text(
                                  '-\$${cart.appliedPromo!.discountValue.toStringAsFixed(2)} applied',
                                  style: const TextStyle(color: AppTheme.primary, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(CupertinoIcons.xmark_circle_fill, color: AppTheme.error),
                            onPressed: () => cart.removePromoCode(),
                          ),
                        ],
                      ),
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _promoController,
                            decoration: const InputDecoration(
                              hintText: 'Enter Promo Code',
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: _isApplyingPromo ? null : () => _applyPromo(cart),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: _isApplyingPromo 
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : const Text('Apply'),
                        ),
                      ],
                    ),
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
                  if (cart.appliedPromo != null) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Discount (${cart.appliedPromo!.promoCode})', style: const TextStyle(color: AppTheme.primary)),
                        Text('-\$${cart.discountAmount.toStringAsFixed(2)}', style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
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
                                shippingAddress: _addressDetail,
                                receiverName: _addressName,
                                receiverPhone: _addressPhone,
                                promoCode: cart.appliedPromo?.promoCode,
                              );

                              if (success) {
                                cart.clear();
                                if (context.mounted) {
                                  Provider.of<NotificationService>(context, listen: false).fetchNotifications();
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
