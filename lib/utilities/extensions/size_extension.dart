import 'package:gamer_tag_task/utilities/page_size_tools.dart';

extension SizeExt on double {
  double get h {
    double screenHeight = SizeTools.screenHeight;
    var res = (this / SizeTools.figmaScreenHeight) * screenHeight;
    return res;
  }

  double get w {
    double screenWidth = SizeTools.screenWidth;
    var res = (this / SizeTools.figmaScreenWidth) * screenWidth;
    return res;
  }
}