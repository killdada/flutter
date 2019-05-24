import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSize {
  AppSize._();

  static void initDesignSize(
      {@required BuildContext context, width: 1080.0, height: 1920.0}) {
    ScreenUtil.instance =
        ScreenUtil(width: width, height: height, allowFontScaling: false)
          ..init(context);
  }

  static ScreenUtil design() {
    return ScreenUtil.getInstance();
  }

  static double width(double width) {
    return design().setWidth(width);
  }

  static double height(double width) {
    return design().setHeight(width);
  }

  static double sp(double fontSize) {
    return design().setSp(fontSize);
  }
}
