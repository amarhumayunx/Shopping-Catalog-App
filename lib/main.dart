import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/providers/app_providers.dart';
import 'core/state/state_listener.dart';
import 'screens/product_listing_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.providers,
      child: AppStateListener(
        child: MaterialApp(
          title: 'Shopping Catalog',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF00FF88), // Bright green accent
              secondary: Color(0xFF00FF88),
              surface: Color(0xFF1A1A1A),
              onPrimary: Colors.black,
              onSecondary: Colors.black,
              onSurface: Colors.white,
            ),
            scaffoldBackgroundColor: const Color(0xFF000000),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF000000),
              foregroundColor: Colors.white,
              elevation: 0,
            ),
            cardTheme: CardThemeData(
              color: const Color(0xFF1A1A1A),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Color(0xFF000000),
              selectedItemColor: Color(0xFF00FF88),
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
            ),
          ),
          home: const ProductListingScreen(),
        ),
      ),
    );
  }
}
