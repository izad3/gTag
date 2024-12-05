import 'package:flutter/material.dart';
import 'package:gamer_tag_task/clippers/ios_chat_container_clipper.dart';
import 'package:gamer_tag_task/utilities/consts.dart';
import 'package:gamer_tag_task/utilities/enums/chat_container_type.dart';
import 'package:gamer_tag_task/utilities/extensions/size_extension.dart';
import 'package:gamer_tag_task/utilities/page_size_tools.dart';
import 'package:gamer_tag_task/widgets/custom_text.dart';

class ChatContainer extends StatelessWidget {
  const ChatContainer({
    super.key,
    this.text,
    this.margin,
    this.backgroundColor,
    this.shadowColor,
    this.alignment,
    this.padding,
    this.chatType = ChatContainerType.send,
    this.clip = true,
    required this.id,
    this.isAnimating = false,
  });
  final String? text;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? shadowColor;
  final MainAxisAlignment? alignment;
  final EdgeInsetsGeometry? padding;
  final ChatContainerType? chatType;
  final bool clip;
  final String id;
  final bool isAnimating;

  EdgeInsetsGeometry _getDefaultPadding() {
    return chatType == ChatContainerType.send
        ? EdgeInsets.only(
            top: 10.0.h,
            bottom: 10.0.h,
            left: 10.0.w,
            right: 20.0.w,
          )
        : EdgeInsets.only(
            top: 10.0.h,
            bottom: 10.0.h,
            left: 20.0.w,
            right: 10.0.w,
          );
  }

  @override
  Widget build(BuildContext context) {
    final containerWidget = buildContainer();

    if (isAnimating) {
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutQuad,
        builder: (context, value, child) {
          final startOffset = Offset(
            - MediaQuery.of(context).size.width + 40.0.w,
            MediaQuery.of(context).size.height * 0.2, 
          );

          final currentOffset = Offset(
            startOffset.dx * (1.0 - value),
            startOffset.dy * (1.0 - value),
          );

          return Transform.translate(
            offset: currentOffset,
            child: Opacity(
              opacity: value,
              child: child,
            ),
          );
        },
        child: containerWidget,
      );
    }

    return containerWidget;
  }

  Widget buildContainer() {
    final mainAxisAlignment = alignment ??
        (chatType == ChatContainerType.send
            ? MainAxisAlignment.end
            : MainAxisAlignment.start);
    final containerMargin = margin ?? EdgeInsets.zero;
    final containerPadding = padding ?? _getDefaultPadding();
    final containerChild = CustomText(
      text ?? '',
      style: regular17.copyWith(
          color: chatType == ChatContainerType.send
              ? whiteTextColor
              : blackTextColor),
    );
    final containerColor = backgroundColor ?? blueColor;

    if (clip) {
      return Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Container(
            margin: containerMargin,
            key: GlobalObjectKey(id),
            constraints:
                BoxConstraints(maxWidth: SizeTools.maxChatContainerWidth),
            child: PhysicalShape(
              clipper: IosChatContainerClipper(
                  type: chatType, radius: 18.0.w, curveSize: 6.0.w),
              color: containerColor,
              shadowColor: shadowColor ?? Colors.grey.shade200,
              child: Padding(
                padding: containerPadding,
                child: containerChild,
              ),
            ),
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Container(
          key: GlobalObjectKey(id),
          constraints:
              BoxConstraints(maxWidth: SizeTools.maxChatContainerWidth),
          margin: containerMargin,
          padding: EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 6.0.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0.w),
            color: containerColor,
          ),
          child: containerChild,
        ),
      ],
    );
  }
}
