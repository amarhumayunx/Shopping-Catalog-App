import 'package:flutter/foundation.dart' hide Category;
import '../models/product.dart';
import '../services/api_service.dart';

class ProductListViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<Category> _categories = [];
  Category? _selectedCategory;
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  List<Product> get products => _filteredProducts;
  List<Category> get categories => _categories;
  Category? get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  ProductListViewModel() {
    loadProducts();
    loadCategories();
  }

  Future<void> loadProducts() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      if (_selectedCategory != null) {
        _products = await _apiService.getProductsByCategory(_selectedCategory!.id);
      } else {
        _products = await _apiService.getProducts();
      }
      _applyFilters();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCategories() async {
    try {
      _categories = await _apiService.getCategories();
      notifyListeners();
    } catch (e) {
      // Handle error silently
    }
  }

  void filterByCategory(Category? category) {
    _selectedCategory = category;
    loadProducts();
  }

  void searchProducts(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void _applyFilters() {
    _filteredProducts = _products.where((product) {
      if (_searchQuery.isEmpty) return true;
      return product.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
    notifyListeners();
  }

  void clearFilters() {
    _selectedCategory = null;
    _searchQuery = '';
    loadProducts();
  }
}

