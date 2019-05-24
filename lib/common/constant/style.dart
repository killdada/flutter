import 'package:flutter/material.dart';
import 'package:myapp/common/utils/appsize.dart';

/// 颜色
class Colours {
  Colours._();

  static const Color background = Colors.white;

  static const Color textFirst = Color(0xFF4A4A4A);
  static const Color textSecond = Color(0xFF909090);
  static const Color textThird = Color(0xFFBDBDBD);

  static const Color blue = Color(0xFF0093FF);
  static const Color blueLight = Color(0xFF00B8FF);

  static const Color divider = Color(0xFFD8D8D8);
}

///文本样式
class myConstant {}

// icon
class myICons {}

class Dimens {
  Dimens._();

  static double sp_30 = AppSize.sp(30.0);
  static double sp_36 = AppSize.sp(36.0);
  static double sp_42 = AppSize.sp(42.0);
  static double sp_45 = AppSize.sp(45.0);
  static double sp_48 = AppSize.sp(48.0);

  static double divider = AppSize.width(1.0);

  static Radius radius_15 = Radius.circular(AppSize.width(15.0));
}
