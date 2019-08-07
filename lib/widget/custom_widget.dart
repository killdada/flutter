import 'package:flutter/material.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/utils/appsize.dart';

class CommonScaffold extends StatelessWidget {
  final Widget appBar;
  final Widget body;
  final Color backgroundColor;

  CommonScaffold({this.appBar, this.body, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.transparent,
      body: SafeArea(
        top: true,
        child: Column(
          children: <Widget>[
            appBar,
            Expanded(
              flex: 1,
              child: body ?? Text('empty'),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget AutoHideKeyboardWidget(BuildContext context, Widget child) {
  return GestureDetector(
    onTap: () {
      hideKeyboard(context);
    },
    child: child,
  );
}

hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(new FocusNode());
}

class CommonAppBar extends StatelessWidget {
  final Color leadingColor;
  final String title;
  final Color titleColor;
  final bool hideDivider;
  final bool hideBacktext;
  final Color backgroundColor;
  final Widget trailing;

  CommonAppBar({
    this.leadingColor,
    this.title,
    this.titleColor,
    this.trailing,
    this.hideDivider = false,
    this.hideBacktext = false,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.appBarHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: hideDivider
            ? null
            : Border(
                bottom: BorderSide(
                  color: Color(0x4C000000),
                  width: AppSize.height(0.5),
                  style: BorderStyle.solid,
                ),
              ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                hideKeyboard(context);
                Navigator.pop(context);
                print('点击返回按钮，自动隐藏键盘');
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.width(20.0)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: AppSize.width(15.0)),
                      child: Image.asset(
                        'assets/images/icn_nav_back.png',
                        width: AppSize.width(20.0),
                        color: leadingColor,
                      ),
                    ),
                    hideBacktext
                        ? Text('')
                        : Text(
                            '返回',
                            style: TextStyle(
                              fontSize: AppSize.sp(32.0),
                              color: leadingColor ?? const Color(0xFF212121),
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: AppSize.sp(36.0),
                  color: titleColor ?? const Color(0xFF212121),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: trailing ?? Text(''),
            ),
          ),
        ],
      ),
    );
  }
}
