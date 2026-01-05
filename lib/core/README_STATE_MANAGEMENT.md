# State Management Architecture

This app uses **Provider** for state management following the **MVVM (Model-View-ViewModel)** architecture pattern.

## Structure

### Core State Management Files

1. **`core/providers/app_providers.dart`**
   - Centralized provider configuration
   - Defines all providers used throughout the app
   - Provides easy access to ViewModels

2. **`core/state/app_state.dart`**
   - Centralized application state
   - Coordinates between different ViewModels
   - Provides utility methods for state management

3. **`core/state/state_manager.dart`**
   - Utility class for easy access to ViewModels
   - Provides both `watch` and `read` methods
   - Simplifies state access in widgets

4. **`core/state/state_listener.dart`**
   - Widgets that listen to state changes
   - Automatically updates UI when state changes
   - Wraps the app to listen to global state changes

## ViewModels

All ViewModels extend `ChangeNotifier` and are provided via Provider:

- **ProductListViewModel** - Manages product listing, search, and filtering
- **CartViewModel** - Manages shopping cart state
- **FavoritesViewModel** - Manages favorite products
- **ProductDetailViewModel** - Manages individual product details (created per screen)
- **CategoryFilterViewModel** - Manages category filtering (created per screen)

## Usage

### Accessing ViewModels in Widgets

```dart
// Using Consumer (rebuilds when state changes)
Consumer<CartViewModel>(
  builder: (context, cartViewModel, child) {
    return Text('Items: ${cartViewModel.itemCount}');
  },
)

// Using Provider.of (read without listening)
final cartViewModel = Provider.of<CartViewModel>(context, listen: false);

// Using context.read (read without listening - recommended)
final cartViewModel = context.read<CartViewModel>();

// Using context.watch (listen to changes)
final cartViewModel = context.watch<CartViewModel>();

// Using StateManager utility
final cartViewModel = StateManager.cart(context);
```

### State Synchronization

- Cart state is automatically synchronized across all screens
- Favorites state is automatically synchronized across all screens
- Product list state is shared across the app
- Product detail and category filter are screen-specific instances

## Benefits

1. **Centralized State** - All state management is organized in one place
2. **Easy Access** - ViewModels are easily accessible from any widget
3. **Automatic Updates** - UI automatically updates when state changes
4. **Separation of Concerns** - Business logic is separated from UI
5. **Testability** - ViewModels can be easily tested independently

