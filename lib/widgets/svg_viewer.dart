import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgViewer extends StatelessWidget {
  const SvgViewer({
    super.key,
    required this.source,
    this.size,
    this.matchTextDirection = false,
    this.color,
    this.headers,
    this.semanticLabel,
    this.fit = BoxFit.cover,
  });

  final String source;
  final double? size;
  final bool matchTextDirection;
  final Color? color;
  final Map<String, String>? headers;
  final BoxFit fit;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      source,
      height: size,
      width: size,
      matchTextDirection: matchTextDirection,
      colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
      fit: fit,
      semanticsLabel: semanticLabel,
    );
  }
}
