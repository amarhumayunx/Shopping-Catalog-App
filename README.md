# Shopping Catalog

A modern, dark-themed shopping catalog mobile application built with Flutter. Browse products, add items to cart, manage favorites, and complete purchases with an elegant user interface.

## Features

- 🛍️ **Product Browsing**: Browse through a catalog of products with beautiful dark theme UI
- 🔍 **Category Filtering**: Filter products by categories with horizontal chip navigation
- ❤️ **Favorites**: Save your favorite products for quick access
- 🛒 **Shopping Cart**: Add products to cart and manage quantities
- 💳 **Checkout**: Complete purchase with delivery information and payment options
- 🎨 **Modern Dark Theme**: Sleek dark interface with green accent colors
- 📱 **Responsive Design**: Optimized for mobile devices

## Screenshots

The app features a modern dark theme with:
- Horizontal category chips for easy filtering
- List view with product cards (image on left, details on right)
- Hero images on product detail screens
- Bottom navigation bar for easy access to main features

## Tech Stack

- **Framework**: Flutter 3.10.4+
- **State Management**: Provider (MVVM Architecture)
- **HTTP Client**: http package
- **Local Storage**: shared_preferences
- **Image Caching**: cached_network_image

## Getting Started

### Prerequisites

- Flutter SDK (3.10.4 or higher)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Git

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/shoppingcatalogapp.git
cd shoppingcatalogapp
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Building APK

To build an APK for Android:

```bash
flutter build apk --release
```

The APK will be generated at: `build/app/outputs/flutter-apk/app-release.apk`

## Project Structure

```
lib/
├── core/
│   ├── providers/       # App-wide providers
│   └── state/           # State management utilities
├── models/              # Data models (Product, CartItem)
├── screens/             # UI screens
│   ├── product_listing_screen.dart
│   ├── product_detail_screen.dart
│   ├── cart_screen.dart
│   ├── favorites_screen.dart
│   ├── category_filter_screen.dart
│   └── checkout_screen.dart
├── services/           # API and storage services
├── viewmodels/         # ViewModels for MVVM pattern
├── widgets/            # Reusable widgets
└── main.dart           # App entry point
```

## Architecture

The app follows the **MVVM (Model-View-ViewModel)** architecture pattern:

- **Models**: Data structures (Product, Category, CartItem)
- **Views**: UI screens and widgets
- **ViewModels**: Business logic and state management using Provider
- **Services**: API calls and local storage

## API Integration

The app integrates with a REST API for fetching products and categories. Make sure to configure the API endpoint in the `services/api_service.dart` file.

## Features in Detail

### Product Listing
- Horizontal scrollable category chips
- List view with product cards
- Search functionality
- Filter by category

### Product Details
- Hero image display
- Product information and description
- Add to cart functionality
- Add to favorites
- Image gallery

### Shopping Cart
- View all cart items
- Update quantities
- Remove items
- Calculate total price
- Proceed to checkout

### Checkout
- Delivery information form
- Payment method selection
- Order summary
- Order confirmation

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is open source and available under the MIT License.

## Author

Developed with ❤️ using Flutter

## Version

Current version: 1.0.0+1
