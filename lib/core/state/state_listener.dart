import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/cart_viewmodel.dart';
import '../../viewmodels/favorites_viewmodel.dart';

/// Widget that listens to cart changes and shows notifications
class CartStateListener extends StatelessWidget {
  final Widget child;

  const CartStateListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<CartViewModel>(
      builder: (context, cartViewModel, child) {
        // Listen to cart changes and show notifications if needed
        // This can be extended to show snackbars, badges, etc.
        return this.child;
      },
    );
  }
}

/// Widget that listens to favorites changes
class FavoritesStateListener extends StatelessWidget {
  final Widget child;

  const FavoritesStateListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesViewModel>(
      builder: (context, favoritesViewModel, child) {
        // Listen to favorites changes
        return this.child;
      },
    );
  }
}

/// Combined state listener for cart and favorites
class AppStateListener extends StatelessWidget {
  final Widget child;

  const AppStateListener({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CartStateListener(
      child: FavoritesStateListener(
        child: child,
      ),
    );
  }
}

