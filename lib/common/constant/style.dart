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
}

///文本样式
class MyConstant {}

// icon
class MyICons {}

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
    fontSize: Dimens.sp_42,
    color: Colours.textFirst,
    fontWeight: FontWeight.normal,
  );

  static TextStyle style2 = TextStyle(
    fontSize: Dimens.sp_36,
    color: Color(0xFF666666),
    fontWeight: FontWeight.normal,
  );

  static TextStyle hintStyle = style.copyWith(
    color: Colours.textThird,
  );
}

class InputStyles {
  static InputDecoration inputDecoration = InputDecoration(
    hintStyle: TextStyles.hintStyle,
    border: InputBorder.none,
    counterText: '',
    contentPadding: EdgeInsets.symmetric(
      vertical: AppSize.height(30.0),
      horizontal: AppSize.width(30.0),
    ),
  );

  static BoxDecoration underlineDecoration = BoxDecoration(
    color: Colours.background,
    border: Border(
        bottom: BorderSide(color: Colours.divider, width: Dimens.divider)),
  );
}

class ButtonStyles {}
