import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/constant/style.dart';

class LoadingDialog extends StatelessWidget {
  final String text;

  LoadingDialog({this.text});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        //保证控件居中效果
        child: SizedBox(
          width: AppSize.width(260.0),
          height: AppSize.width(260.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.all(Dimens.radius_15),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: AppSize.width(15.0)),
                  child: CupertinoActivityIndicator(
                    radius: AppSize.width(45.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: AppSize.width(30.0)),
                  child: Text(
                    text ?? '加载中...',
                    style: TextStyles.style,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
