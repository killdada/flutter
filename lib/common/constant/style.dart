import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  static const Color lightGray = Color(0xFF999999);
  static const Color lightRed = Color(0xFFF73E4D);
}

///文本样式
class MyConstant {}

// icon
class MyICons {}

class Dimens {
  Dimens._();
  static double sp_24 = AppSize.sp(24.0);
  static double sp_28 = AppSize.sp(28.0);
  static double sp_30 = AppSize.sp(30.0);
  static double sp_32 = AppSize.sp(32.0);
  static double sp_36 = AppSize.sp(36.0);
  static double sp_42 = AppSize.sp(42.0);
  static double sp_40 = AppSize.sp(40.0);
  static double sp_45 = AppSize.sp(45.0);
  static double sp_46 = AppSize.sp(46.0);
  static double sp_48 = AppSize.sp(48.0);

  static double divider = AppSize.width(2.0);

  static Radius radius_6 = Radius.circular(AppSize.width(6.0));
  static Radius radius_8 = Radius.circular(AppSize.width(8.0));
  static Radius radius_10 = Radius.circular(AppSize.width(10.0));
  static Radius radius_12 = Radius.circular(AppSize.width(12.0));
  static Radius radius_15 = Radius.circular(AppSize.width(15.0));
  static Radius radius_16 = Radius.circular(AppSize.width(16.0));
  static Radius radius_23 = Radius.circular(AppSize.width(23.0));

  static double appBarHeight = AppSize.height(90);
}

class SystemStyles {
  static void setStatusBarStyle(
      {statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark}) {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness,
      ));
    }
  }
}

class TextStyles {
  static TextStyle style = TextStyle(
    fontSize: Dimens.sp_32,
    color: Colours.textFirst,
    fontWeight: FontWeight.normal,
  );

  static TextStyle style2 = TextStyle(
    fontSize: Dimens.sp_28,
    color: Color(0xFF666666),
    fontWeight: FontWeight.normal,
  );

  static TextStyle hintStyle =
      TextStyle(color: Colours.textThird, fontSize: Dimens.sp_30);
}

class InputStyles {
  static InputDecoration inputDecoration = InputDecoration(
    hintStyle: TextStyles.hintStyle,
    border: InputBorder.none,
    counterText: '',
    contentPadding: EdgeInsets.symmetric(
      vertical: AppSize.height(20.0),
      horizontal: AppSize.width(20.0),
    ),
  );

  static BoxDecoration underlineDecoration = BoxDecoration(
    color: Colours.background,
    border: Border(
        bottom: BorderSide(color: Colours.divider, width: Dimens.divider)),
  );
}

class ButtonStyles {}
