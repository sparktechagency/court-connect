import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShape boxShape;
  final Color? backgroundColor;
  final Widget? child;
  final ColorFilter? colorFilter;

  const CustomNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.border,
    this.borderRadius,
    this.boxShape = BoxShape.rectangle,
    this.backgroundColor,
    this.child,
    this.colorFilter,
  });

  @override
  Widget build(BuildContext context) {
    // Handle empty or invalid URL
    if (imageUrl.isEmpty || !Uri.tryParse(imageUrl)!.hasAbsolutePath == true) {
      return _buildErrorContainer();
    }

    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          borderRadius: borderRadius,
          shape: boxShape,
          color: backgroundColor,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            colorFilter: colorFilter,
          ),
        ),
        child: child,
      ),
      placeholder: (context, url) => _buildShimmerContainer(),
      errorWidget: (context, url, error) {
        debugPrint('Image load error for $url: $error');
        return _buildErrorContainer();
      },
    );
  }

  Widget _buildShimmerContainer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.6),
      highlightColor: Colors.grey.withOpacity(0.3),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          color: Colors.grey.withOpacity(0.6),
          borderRadius: borderRadius,
          shape: boxShape,
        ),
      ),
    );
  }

  Widget _buildErrorContainer() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: border,
        color: Colors.grey.withOpacity(0.6),
        borderRadius: borderRadius,
        shape: boxShape,
      ),
      child: const Icon(Icons.error, color: Colors.white),
    );
  }
}
