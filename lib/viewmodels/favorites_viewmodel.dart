import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/storage_service.dart';

class FavoritesViewModel extends ChangeNotifier {
  final StorageService _storageService = StorageService();

  List<Product> _favorites = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;

  FavoritesViewModel() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _favorites = await _storageService.getFavorites();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> removeFavorite(int productId) async {
    final success = await _storageService.removeFromFavorites(productId);
    if (success) {
      _favorites.removeWhere((p) => p.id == productId);
      notifyListeners();
    }
    return success;
  }
}

