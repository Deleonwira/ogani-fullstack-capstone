import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_client.dart';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  Map<String, dynamic>? _user;
  bool _isLoading = true;

  bool get isAuthenticated => _isAuthenticated;
  Map<String, dynamic>? get user => _user;
  bool get isLoading => _isLoading;

  AuthProvider() {
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');
    
    if (token != null) {
      // Decode token or fetch user profile
      try {
        final userData = prefs.getString('user_data');
        if (userData != null) {
          _user = jsonDecode(userData);
          _isAuthenticated = true;
          
          // Fetch fresh user data from API to replace mock/cache
          try {
            final userId = _user!['userId'];
            final response = await ApiClient.get('/users/$userId');
            if (response.statusCode == 200) {
              final freshData = jsonDecode(response.body);
              if (freshData['success'] == true && freshData['data'] != null) {
                _user = freshData['data'];
                await prefs.setString('user_data', jsonEncode(_user));
              }
            }
          } catch (e) {
            debugPrint('Failed to fetch fresh user data: $e');
          }
        }
      } catch (e) {
        // Token invalid or expired
        await logout();
      }
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<String?> login(String email, String password) async {
    try {
      final response = await ApiClient.post('/auth/login', {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final token = data['data']['token'];
          final userMap = data['data']['user'];
          
          if (userMap['role'] != 'CUSTOMER') {
            return 'Access denied. Only customers can login from the mobile app.';
          }
          
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('jwt_token', token);
          await prefs.setString('user_data', jsonEncode(userMap));
          
          _user = userMap;
          _isAuthenticated = true;
          notifyListeners();
          return null; // success
        }
        return data['message'] ?? 'Login failed. Please check your credentials.';
      }
      return 'Server error. Please try again later.';
    } catch (e) {
      debugPrint('Login error: $e');
      return 'Network error. Please check your connection.';
    }
  }

  Future<bool> register(String fullName, String username, String email, String password) async {
    try {
      final response = await ApiClient.post('/auth/register', {
        'fullName': fullName,
        'username': username,
        'email': email,
        'password': password,
      });

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      debugPrint('Registration error: $e');
      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('user_data');
    
    _user = null;
    _isAuthenticated = false;
    notifyListeners();
  }
}
