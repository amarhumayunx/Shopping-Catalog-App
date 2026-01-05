import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../models/cart_item.dart';
import '../utils/constants.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  Future<SharedPreferences> get _prefs async =>
      await SharedPreferences.getInstance();

  // Favorites
  Future<List<Product>> getFavorites() async {
    try {
      final prefs = await _prefs;
      final favoritesJson = prefs.getString(StorageKeys.favorites);
      if (favoritesJson == null) return [];
      
      final List<dynamic> data = json.decode(favoritesJson);
      return data.map((json) => Product.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> addToFavorites(Product product) async {
    try {
      final favorites = await getFavorites();
      if (favorites.any((p) => p.id == product.id)) {
        return false; // Already in favorites
      }
      
      favorites.add(product);
      final prefs = await _prefs;
      await prefs.setString(
        StorageKeys.favorites,
        json.encode(favorites.map((p) => p.toJson()).toList()),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromFavorites(int productId) async {
    try {
      final favorites = await getFavorites();
      favorites.removeWhere((p) => p.id == productId);
      
      final prefs = await _prefs;
      await prefs.setString(
        StorageKeys.favorites,
        json.encode(favorites.map((p) => p.toJson()).toList()),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> isFavorite(int productId) async {
    final favorites = await getFavorites();
    return favorites.any((p) => p.id == productId);
  }

  // Cart
  Future<List<CartItem>> getCart() async {
    try {
      final prefs = await _prefs;
      final cartJson = prefs.getString(StorageKeys.cart);
      if (cartJson == null) return [];
      
      final List<dynamic> data = json.decode(cartJson);
      return data.map((json) => CartItem.fromJson(json)).toList();
    } catch (e) {
      return [];
    }
  }

  Future<bool> addToCart(Product product, {int quantity = 1}) async {
    try {
      final cart = await getCart();
      final existingIndex = cart.indexWhere((item) => item.product.id == product.id);
      
      if (existingIndex != -1) {
        cart[existingIndex].quantity += quantity;
      } else {
        cart.add(CartItem(product: product, quantity: quantity));
      }
      
      final prefs = await _prefs;
      await prefs.setString(
        StorageKeys.cart,
        json.encode(cart.map((item) => item.toJson()).toList()),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeFromCart(int productId) async {
    try {
      final cart = await getCart();
      cart.removeWhere((item) => item.product.id == productId);
      
      final prefs = await _prefs;
      await prefs.setString(
        StorageKeys.cart,
        json.encode(cart.map((item) => item.toJson()).toList()),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateCartQuantity(int productId, int quantity) async {
    try {
      final cart = await getCart();
      final existingIndex = cart.indexWhere((item) => item.product.id == productId);
      
      if (existingIndex != -1) {
        if (quantity <= 0) {
          cart.removeAt(existingIndex);
        } else {
          cart[existingIndex].quantity = quantity;
        }
        
        final prefs = await _prefs;
        await prefs.setString(
          StorageKeys.cart,
          json.encode(cart.map((item) => item.toJson()).toList()),
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearCart() async {
    try {
      final prefs = await _prefs;
      await prefs.remove(StorageKeys.cart);
      return true;
    } catch (e) {
      return false;
    }
  }
}

