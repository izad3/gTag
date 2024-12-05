import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    super.key,
    required this.asset,
    this.fit = BoxFit.cover,
    this.errorBuilder,
    this.height,
    this.width,
    this.headers,
    this.alignment = Alignment.center,
    this.cacheWidth,
    this.bytes,
  });

  final String asset;
  final BoxFit fit;
  final Widget? errorBuilder;
  final double? height;
  final double? width;
  final double? cacheWidth;
  final Uint8List? bytes;
  final Alignment alignment;

  final Map<String, String>? headers;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      fit: fit,
      alignment: alignment,
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      errorBuilder: (_, __, ___) {
        return errorBuilder ??
            Container(
              color: Colors.red,
            );
      },
      cacheWidth: cacheWidth?.toInt(),
    );
  }
}
