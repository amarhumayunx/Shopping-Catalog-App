import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/category_filter_viewmodel.dart';

class CategoryFilterScreen extends StatelessWidget {
  const CategoryFilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter by Category'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Consumer<CategoryFilterViewModel>(
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
                    onPressed: () => viewModel.loadCategories(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (viewModel.categories.isEmpty) {
            return const Center(child: Text('No categories found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: viewModel.categories.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.clear_all),
                    title: const Text('All Categories'),
                    onTap: () {
                      Navigator.pop(context, null);
                    },
                  ),
                );
              }

              final category = viewModel.categories[index - 1];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    backgroundImage: category.image.isNotEmpty && 
                        (category.image.startsWith('http://') || category.image.startsWith('https://'))
                        ? NetworkImage(category.image)
                        : null,
                    onBackgroundImageError: (exception, stackTrace) {
                      // Handle image loading error silently
                    },
                    child: category.image.isEmpty || 
                        (!category.image.startsWith('http://') && !category.image.startsWith('https://'))
                        ? const Icon(Icons.category)
                        : null,
                  ),
                  title: Text(category.name),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pop(context, category);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

