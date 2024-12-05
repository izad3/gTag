import 'package:flutter/material.dart';
import 'package:gamer_tag_task/utilities/enums/chat_container_type.dart';

class IosChatContainerClipper extends CustomClipper<Path> {
  final ChatContainerType? type;
  final double radius;
  final double curveSize;

  IosChatContainerClipper({this.type, this.radius = 18.0, this.curveSize = 7});

  @override
  Path getClip(Size size) {
    var path = Path();
    if (type == ChatContainerType.send) {
      path.moveTo(radius, 0);

      path.lineTo(size.width - radius - curveSize, 0);

      path.arcToPoint(Offset(size.width - curveSize, radius),
          radius: Radius.circular(radius));

      path.lineTo(size.width - curveSize, size.height - curveSize);

      path.arcToPoint(Offset(size.width, size.height),
          radius: Radius.circular(curveSize), clockwise: false);

      path.arcToPoint(Offset(size.width - 2 * curveSize, size.height - curveSize),
          radius: Radius.circular(2 * curveSize));

      path.arcToPoint(Offset(size.width - 4 * curveSize, size.height),
          radius: Radius.circular(2 * curveSize));

      path.lineTo(radius, size.height);

      path.arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius));

      path.lineTo(0, radius);

      path.arcToPoint(Offset(radius, 0), radius: Radius.circular(radius));
    } else {
      path.moveTo(radius, 0);

      path.lineTo(size.width - radius, 0);

      path.arcToPoint(Offset(size.width, radius),
          radius: Radius.circular(radius));

      path.lineTo(size.width, size.height - radius);

      path.arcToPoint(Offset(size.width - radius, size.height),
          radius: Radius.circular(radius));

      path.lineTo(4 * curveSize, size.height);

      path.arcToPoint(Offset(2 * curveSize, size.height - curveSize),
          radius: Radius.circular(2 * curveSize));

      path.arcToPoint(Offset(0, size.height),
          radius: Radius.circular(2 * curveSize));

      path.arcToPoint(Offset(curveSize, size.height - curveSize),
          radius: Radius.circular(curveSize), clockwise: false);

      path.lineTo(curveSize, radius);

      path.arcToPoint(Offset(radius + curveSize, 0),
          radius: Radius.circular(radius));
    }
    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}