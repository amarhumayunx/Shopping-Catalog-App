import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../services/storage_service.dart';

class CartViewModel extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  List<CartItem> _cartItems = [];
  bool _isLoading = false;
  String? _error;

  List<CartItem> get cartItems => _cartItems;
  bool get isLoading => _isLoading;
  String? get error => _error;

  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get itemCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  CartViewModel() {
    loadCart();
  }

  Future<void> loadCart() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _cartItems = await _storageService.getCart();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateQuantity(int productId, int quantity) async {
    final success = await _storageService.updateCartQuantity(productId, quantity);
    if (success) {
      await loadCart();
    }
    return success;
  }

  Future<bool> removeItem(int productId) async {
    final success = await _storageService.removeFromCart(productId);
    if (success) {
      await loadCart();
    }
    return success;
  }

  Future<bool> clearCart() async {
    final success = await _storageService.clearCart();
    if (success) {
      await loadCart();
    }
    return success;
  }
}

