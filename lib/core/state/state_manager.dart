import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../viewmodels/favorites_viewmodel.dart';
import '../../viewmodels/product_list_viewmodel.dart';

/// State Manager utility class for easy access to app state
class StateManager {
  /// Get AppState from context
  static AppState appState(BuildContext context) {
    return Provider.of<AppState>(context, listen: false);
  }

  /// Get ProductListViewModel from context
  static ProductListViewModel productList(BuildContext context) {
    return Provider.of<ProductListViewModel>(context, listen: false);
  }

  /// Get CartViewModel from context
  static CartViewModel cart(BuildContext context) {
    return Provider.of<CartViewModel>(context, listen: false);
  }

  /// Get FavoritesViewModel from context
  static FavoritesViewModel favorites(BuildContext context) {
    return Provider.of<FavoritesViewModel>(context, listen: false);
  }

  /// Watch AppState from context
  static AppState watchAppState(BuildContext context) {
    return Provider.of<AppState>(context);
  }

  /// Watch ProductListViewModel from context
  static ProductListViewModel watchProductList(BuildContext context) {
    return Provider.of<ProductListViewModel>(context);
  }

  /// Watch CartViewModel from context
  static CartViewModel watchCart(BuildContext context) {
    return Provider.of<CartViewModel>(context);
  }

  /// Watch FavoritesViewModel from context
  static FavoritesViewModel watchFavorites(BuildContext context) {
    return Provider.of<FavoritesViewModel>(context);
  }
}

