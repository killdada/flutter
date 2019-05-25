import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myapp/common/utils/appsize.dart';

class CustomAppBar extends CupertinoNavigationBar {
  CustomAppBar(BuildContext context, String title)
      : super(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.arrow_back_ios,
                  color: const Color(0xFF212121),
                  size: AppSize.sp(65.0),
                ),
                Text(
                  '返回',
                  style: TextStyle(
                    fontSize: AppSize.sp(42.0),
                    color: const Color(0xFF212121),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          padding: EdgeInsetsDirectional.only(
            start: AppSize.width(10.0),
            end: AppSize.width(10.0),
          ),
          middle: Text(
            title,
            style: TextStyle(
              fontSize: AppSize.sp(51.0),
              color: const Color(0xFF212121),
              fontWeight: FontWeight.normal,
            ),
          ),
        );
}
