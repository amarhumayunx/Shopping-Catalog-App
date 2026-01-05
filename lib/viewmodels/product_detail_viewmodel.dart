import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class ProductDetailViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();

  Product? _product;
  bool _isLoading = false;
  String? _error;
  bool _isFavorite = false;

  Product? get product => _product;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isFavorite => _isFavorite;

  Future<void> loadProduct(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _product = await _apiService.getProduct(id);
      _isFavorite = await _storageService.isFavorite(id);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> toggleFavorite() async {
    if (_product == null) return false;

    if (_isFavorite) {
      final success = await _storageService.removeFromFavorites(_product!.id);
      if (success) {
        _isFavorite = false;
        notifyListeners();
        return true;
      }
    } else {
      final success = await _storageService.addToFavorites(_product!);
      if (success) {
        _isFavorite = true;
        notifyListeners();
        return true;
      }
    }
    return false;
  }

  Future<bool> addToCart({int quantity = 1}) async {
    if (_product == null) return false;
    return await _storageService.addToCart(_product!, quantity: quantity);
  }
}

