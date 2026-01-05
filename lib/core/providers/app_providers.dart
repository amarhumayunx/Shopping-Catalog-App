import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import '../../viewmodels/product_list_viewmodel.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../viewmodels/favorites_viewmodel.dart';
import '../../viewmodels/product_detail_viewmodel.dart';
import '../../viewmodels/category_filter_viewmodel.dart';

/// Centralized provider setup for the entire app
class AppProviders {
  /// Main providers for the app - these are available throughout the app
  static List<SingleChildWidget> get providers => [
        // Product List ViewModel
        ChangeNotifierProvider<ProductListViewModel>(
          create: (_) => ProductListViewModel(),
        ),
        // Cart ViewModel
        ChangeNotifierProvider<CartViewModel>(
          create: (_) => CartViewModel(),
        ),
        // Favorites ViewModel
        ChangeNotifierProvider<FavoritesViewModel>(
          create: (_) => FavoritesViewModel(),
        ),
      ];

  /// Providers for screens that need their own instances
  static List<SingleChildWidget> get detailProviders => [
        ChangeNotifierProvider<ProductDetailViewModel>(
          create: (_) => ProductDetailViewModel(),
        ),
      ];

  static List<SingleChildWidget> get categoryFilterProviders => [
        ChangeNotifierProvider<CategoryFilterViewModel>(
          create: (_) => CategoryFilterViewModel(),
        ),
      ];
}

