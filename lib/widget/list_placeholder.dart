import 'package:flutter/material.dart';

import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/constant/style.dart';

class ListPlaceholder extends StatelessWidget {
  final String assetsIcon;
  final String hint;

  ListPlaceholder(this.assetsIcon, this.hint, {Key key}) : super(key: key);

  ListPlaceholder.empty({Key key, String assetsIcon, String hint})
      : assetsIcon = assetsIcon ?? 'assets/images/img_empty.png',
        hint = hint ?? '当前页面没有数据~',
        super(key: key);

  ListPlaceholder.error({Key key, String assetsIcon, String hint})
      : assetsIcon = assetsIcon ?? 'assets/images/img_net_error.png',
        hint = hint ?? '哎呀，网络连接中断',
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox.fromSize(
            size: Size.square(AppSize.width(450.0)),
            child: Image.asset(assetsIcon),
          ),
          Padding(
            padding: EdgeInsets.only(top: AppSize.height(100.0)),
            child: Text(
              hint,
              style: TextStyle(
                color: const Color(0xFFC6C8D1),
                fontSize: Dimens.sp_45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
