import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/product_detail_viewmodel.dart';
import '../viewmodels/cart_viewmodel.dart';
import '../widgets/safe_network_image.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductDetailViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (viewModel.error != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${viewModel.error}'),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              );
            }

            final product = viewModel.product;
            if (product == null) {
              return const Center(child: Text('Product not found'));
            }

            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: true,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: product.bestImageUrl.isNotEmpty
                        ? SafeNetworkImage(
                            imageUrl: product.bestImageUrl,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.image_not_supported, size: 64),
                          ),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(
                        viewModel.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: viewModel.isFavorite ? Colors.red : Colors.white,
                      ),
                      onPressed: () async {
                        final success = await viewModel.toggleFavorite();
                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                viewModel.isFavorite
                                    ? 'Added to favorites'
                                    : 'Removed from favorites',
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          product.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        if (product.validImages.length > 1) ...[
                          const Text(
                            'More Images',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: product.validImages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: SafeNetworkImage(
                                    imageUrl: product.validImages[index],
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      bottomNavigationBar: Consumer<ProductDetailViewModel>(
        builder: (context, viewModel, child) {
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final success = await viewModel.addToCart();
                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to cart'),
                            ),
                          );
                          // Refresh cart count
                          context.read<CartViewModel>().loadCart();
                        }
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Add to Cart'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
    );
  }
}

