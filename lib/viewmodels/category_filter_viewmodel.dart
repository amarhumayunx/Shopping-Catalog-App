import 'package:flutter/foundation.dart' hide Category;
import '../models/product.dart';
import '../services/api_service.dart';

class CategoryFilterViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Category> _categories = [];
  bool _isLoading = false;
  String? _error;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  CategoryFilterViewModel() {
    loadCategories();
  }

  Future<void> loadCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _categories = await _apiService.getCategories();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

