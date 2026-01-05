import 'package:flutter/foundation.dart';
import '../../viewmodels/product_list_viewmodel.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../viewmodels/favorites_viewmodel.dart';

/// Centralized application state management
/// This class provides a centralized way to access and manage app-wide state
class AppState extends ChangeNotifier {
  // State flags
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  AppState() {
    _isInitialized = true;
  }

  /// Refresh all data - call this with ViewModels from context
  Future<void> refreshAll(
    ProductListViewModel productList,
    CartViewModel cart,
    FavoritesViewModel favorites,
  ) async {
    await Future.wait([
      productList.loadProducts(),
      cart.loadCart(),
      favorites.loadFavorites(),
    ]);
  }
}

