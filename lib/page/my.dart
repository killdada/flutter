import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';

import 'package:myapp/common/constant/style.dart';
import 'package:myapp/router/application.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/model/userinfo.dart';
import 'package:myapp/common/dao/user_dao.dart';

class My extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyPageState();
  }
}

class _MenuItems {
  String name, icon;
  _MenuItems(this.name, this.icon);
}

class MyPageState extends State<My> {
  final myMenus = [
    _MenuItems('学习记录', 'assets/images/icon_personal_record.png'),
    _MenuItems('本周学习时长', 'assets/images/icon_personal_week.png'),
    _MenuItems('累计学习时长', 'assets/images/icon_personal_total.png'),
    _MenuItems('退出登录', 'assets/images/icon_personal_setting.png'),
  ];

  UserInfo userinfo = UserInfo();

  @override
  void initState() {
    super.initState();
    initUserInfo();
  }

  // 初始化用户信息
  initUserInfo({String type}) async {
    if (type == 'refresh') {
      var a = await UserDao.getUserInfo();
      print(a);
    }
    UserInfo userInfoLocal = await DataUtils.getUserInfo();
    print(userInfoLocal);
    setState(() {
      userinfo = userInfoLocal;
    });
  }

  // 跳转到登录页面，并且如果登录成功以后，登录页面pop返回一个参数refresh，告知页面刷新用户信息
  login() async {
    /// 使用
    Application.router
        .navigateTo(context, "/login", transition: TransitionType.native)
        .then((result) {
      if (result != null && result == "refresh") {
        // 刷新用户信息
        initUserInfo(type: result);
      }
    });
  }

  _showLoginDialog() {}

  _handleMenuItemClick(String title) {
    DataUtils.isLogin().then((isLogin) {
      if (!isLogin) {
        // 未登录
        _showLoginDialog();
      } else {
        print('goto>>');
      }
    });
  }

  // 页面头部，展示用户信息
  Widget _header() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppSize.width(57.0),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.width(23.0),
        vertical: AppSize.height(60.0),
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colours.divider,
            width: Dimens.divider,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: AppSize.width(85.0),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: userinfo.avatar ?? '',
              placeholder: (context, url) =>
                  Image.asset('assets/images/user_avatar.png'),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/user_avatar.png'),
            ),
          ),
        ],
      ),
    );
  }

  // 展示我的菜单导航menu
  Widget _menuItem() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: true,
        child: Column(children: <Widget>[
          _header(),
          _menuItem(),
        ]));
  }
}
