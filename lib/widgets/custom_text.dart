import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  const CustomText(
    this.data, {
    super.key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.maxLines,
    this.semanticLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
    this.description,
    this.isSelectable = false,
    this.textScaler,
  });

  final String data;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextScaler? textScaler;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  final String? description;
  final bool isSelectable;

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    final resultWidget = Text(
      widget.data,
      style: widget.style,
      strutStyle: widget.strutStyle,
      textAlign: widget.textAlign,
      textDirection: widget.textDirection,
      softWrap: widget.softWrap,
      overflow: widget.overflow,
      textScaler: widget.textScaler,
      maxLines: widget.maxLines,
      semanticsLabel: widget.semanticLabel,
      textWidthBasis: widget.textWidthBasis,
      textHeightBehavior: widget.textHeightBehavior,
      selectionColor: widget.selectionColor,
    );
    if (widget.isSelectable) {
      return SelectionArea(child: resultWidget);
    }
    return resultWidget;
  }
}
