import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

/// Safe network image widget that checks if image exists before loading
class SafeNetworkImage extends StatefulWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final Widget? placeholder;
  final Widget? errorWidget;

  const SafeNetworkImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.placeholder,
    this.errorWidget,
  });

  @override
  State<SafeNetworkImage> createState() => _SafeNetworkImageState();
}

class _SafeNetworkImageState extends State<SafeNetworkImage> {
  bool _isChecking = true;
  bool _imageExists = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _checkImageExists();
  }

  Future<void> _checkImageExists() async {
    // First validate URL format
    if (widget.imageUrl.isEmpty || !_isValidUrl(widget.imageUrl)) {
      if (mounted) {
        setState(() {
          _hasError = true;
          _isChecking = false;
        });
      }
      return;
    }

    try {
      // Check if image exists using HEAD request (faster than GET)
      final response = await http.head(
        Uri.parse(widget.imageUrl),
      ).timeout(
        const Duration(seconds: 5),
        onTimeout: () {
          throw Exception('Image check timeout');
        },
      );

      if (mounted) {
        setState(() {
          _imageExists = response.statusCode == 200;
          _hasError = response.statusCode != 200;
          _isChecking = false;
        });
      }
    } catch (e) {
      // If HEAD fails, try GET with limited data
      try {
        final response = await http.get(
          Uri.parse(widget.imageUrl),
        ).timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            throw Exception('Image check timeout');
          },
        );

        if (mounted) {
          setState(() {
            _imageExists = response.statusCode == 200 && 
                          response.headers['content-type']?.startsWith('image/') == true;
            _hasError = !_imageExists;
            _isChecking = false;
          });
        }
      } catch (e2) {
        debugPrint('Image check failed for URL: ${widget.imageUrl}, Error: $e2');
        if (mounted) {
          setState(() {
            _hasError = true;
            _isChecking = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show placeholder while checking
    if (_isChecking) {
      return widget.placeholder != null
          ? widget.placeholder!
          : Container(
              color: Colors.grey[200],
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
    }

    // Show error if image doesn't exist or URL is invalid
    if (_hasError || !_imageExists) {
      return widget.errorWidget != null
          ? widget.errorWidget!
          : _buildErrorWidget();
    }

    // Load image if it exists
    return CachedNetworkImage(
      imageUrl: widget.imageUrl,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
      placeholder: widget.placeholder != null
          ? (context, url) => widget.placeholder!
          : (context, url) => Container(
              color: Colors.grey[200],
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
      errorWidget: widget.errorWidget != null
          ? (context, url, error) => widget.errorWidget!
          : (context, url, error) {
              debugPrint('Image loading error: $error for URL: $url');
              return _buildErrorWidget();
            },
      // Add cache configuration to handle problematic images
      memCacheWidth: widget.width?.toInt(),
      memCacheHeight: widget.height?.toInt(),
      // Use fadeIn for smoother loading
      fadeInDuration: const Duration(milliseconds: 300),
      fadeOutDuration: const Duration(milliseconds: 100),
      // Handle HTTP errors
      httpHeaders: const {
        'Accept': 'image/*',
      },
    );
  }

  Widget _buildErrorWidget() {
    return Container(
      color: Colors.grey[300],
      child: Icon(
        Icons.image_not_supported,
        size: widget.width != null ? (widget.width! * 0.5) : 48,
        color: Colors.grey[600],
      ),
    );
  }

  bool _isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}

