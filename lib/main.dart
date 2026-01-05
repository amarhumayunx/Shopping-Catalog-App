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
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const ProductListingScreen(),
        ),
      ),
    );
  }
}
