class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final List<String> images;
  final Category category;
  final DateTime? creationAt;
  final DateTime? updatedAt;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
    this.creationAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      category: json['category'] is Map
          ? Category.fromJson(json['category'])
          : Category(id: json['categoryId'] ?? 0, name: '', image: ''),
      creationAt: json['creationAt'] != null
          ? DateTime.tryParse(json['creationAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'images': images,
      'category': category.toJson(),
      'creationAt': creationAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  /// Check if URL is a placeholder image
  bool _isPlaceholderImage(String url) {
    if (url.isEmpty) return true;
    final lowerUrl = url.toLowerCase();
    // Check for common placeholder services
    return lowerUrl.contains('placehold') || 
           lowerUrl.contains('placeholder') ||
           lowerUrl.contains('placeimg.com') ||
           lowerUrl.contains('via.placeholder');
  }

  /// Get the best available image URL
  /// Filters out placeholder URLs and uses category image as fallback
  String get bestImageUrl {
    // Filter out placeholder URLs - prioritize product's own images
    final validProductImages = images.where((url) {
      return !_isPlaceholderImage(url);
    }).toList();

    // Use first valid image from product images (priority to product's own images)
    if (validProductImages.isNotEmpty) {
      return validProductImages[0];
    }

    // Fallback to category image if available and valid
    if (category.image.isNotEmpty && !_isPlaceholderImage(category.image)) {
      return category.image;
    }

    // Return empty string if no valid image found
    return '';
  }

  /// Get all valid image URLs (excluding placeholders)
  List<String> get validImages {
    // Filter out placeholder URLs from product images
    final validProductImages = images.where((url) {
      return !_isPlaceholderImage(url);
    }).toList();

    // Add category image if it's valid and not already in the list
    if (category.image.isNotEmpty && 
        !_isPlaceholderImage(category.image) &&
        !validProductImages.contains(category.image)) {
      validProductImages.add(category.image);
    }

    return validProductImages;
  }
}

class Category {
  final int id;
  final String name;
  final String image;

  Category({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}

