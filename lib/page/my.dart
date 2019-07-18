import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:myapp/router/application.dart';

import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/date_utils.dart';
import 'package:myapp/common/utils/fluro_convert_util.dart';
import 'package:myapp/common/model/userinfo.dart';
import 'package:myapp/common/dao/user_dao.dart';
import 'package:myapp/common/event/event_bus.dart';
import 'package:myapp/common/event/login_event.dart';

class My extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyPageState();
  }
}

class _MenuItems {
  String name, icon, link;
  _MenuItems(this.name, this.icon, this.link);
}

class MyPageState extends State<My> {
  final myMenus = [
    _MenuItems(
        '学习记录', 'assets/images/icon_personal_record.png', '/learnrecord'),
    _MenuItems('本周学习时长', 'assets/images/icon_personal_week.png',
        '/learnrank?title=${FluroConvertUtils.fluroCnParamsEncode('本周排行榜')}'),
    _MenuItems('累计学习时长', 'assets/images/icon_personal_total.png',
        '/learnrank?title=${FluroConvertUtils.fluroCnParamsEncode('累计排行榜')}'),
    _MenuItems('退出登录', 'assets/images/icon_personal_setting.png', ''),
  ];

  UserInfo userinfo = UserInfo();

  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    initUserInfo();

    MyEventBus.event.on<LogoutEvent>().listen((event) {
      // 收到退出登录的消息，刷新个人信息显示
      _loginOut();
    });
    MyEventBus.event.on<LoginEvent>().listen((event) {
      // 收到登录的消息，重新获取个人信息
      _refreshUserInfo();
    });
  }

  void _refreshUserInfo() async {
    var userInfoLocal = await UserDao.getUserInfo();
    if (mounted) {
      if (userInfoLocal != null) {
        setState(() {
          isLogin = true;
          userinfo = userInfoLocal;
        });
      } else {
        setState(() {
          isLogin = false;
        });
      }
    }
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  // 初始化用户信息
  initUserInfo() async {
    bool logined = await DataUtils.isLogin();
    if (logined) {
      _refreshUserInfo();
    }
  }

  // 用户头像, 如果存在使用缓存图片，不存在使用本地默认图片
  Widget _avatar(String img) {
    if (img != '') {
      return CachedNetworkImage(
        fit: BoxFit.fill,
        imageUrl: img,
        placeholder: (context, url) =>
            Image.asset('assets/images/user_avatar.png'),
        errorWidget: (context, url, error) =>
            Image.asset('assets/images/user_avatar.png'),
      );
    }
    return Image.asset('assets/images/user_avatar.png');
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
              child: _avatar(userinfo.userAvater ?? '')),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: AppSize.width(45)),
              child: Text(
                '${userinfo.userShowName ?? '未登录'}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: AppSize.sp(35)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void gotoPage(String address, {bool replace = false}) {
    Application.router.navigateTo(
      context,
      address,
      transition: TransitionType.native,
    );
  }

  void _loginOut() {
    setState(() {
      isLogin = false;
      userinfo = UserInfo();
    });
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
            title: Text('提示'),
            content: Text('是否退出当前账号'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('取消'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoDialogAction(
                child: Text('确定'),
                onPressed: () {
                  // 本地state
                  _loginOut();
                  // 存储data
                  DataUtils.logout();
                  Navigator.of(context)
                    ..pop()
                    ..pushReplacementNamed('/login');
                },
              ),
            ],
          ),
    );
  }

  Widget _menuItemRightText(String name) {
    if (name == '累计学习时长' && isLogin) {
      return Text(
        DateUtil.formatTime(userinfo.studyTimeWeek),
        style: TextStyle(
          fontSize: AppSize.sp(25),
          color: Colours.textSecond,
        ),
      );
    }
    return Text('');
  }

  Widget _renderMenuItem(_MenuItems item) {
    return InkWell(
      onTap: () {
        if (isLogin) {
          if (item.name == '退出登录') {
            _showLoginDialog();
          } else {
            gotoPage(item.link);
          }
        } else {
          gotoPage('/login');
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(50.0),
          vertical: AppSize.height(50.0),
        ),
        child: Row(
          children: <Widget>[
            Image.asset(
              item.icon,
              width: AppSize.width(50.0),
              height: AppSize.height(50.0),
            ),
            SizedBox(
              width: AppSize.width(20),
            ),
            Expanded(
              flex: 1,
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: Dimens.sp_30,
                ),
              ),
            ),
            _menuItemRightText(item.name),
            Icon(
              Icons.navigate_next,
              size: AppSize.sp(35.0),
              color: Color(0xFFBCBCBC),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];

    children.add(_header());
    myMenus.forEach((item) {
      children.add(_renderMenuItem(item));
    });

    return SafeArea(top: true, child: Column(children: children));
  }
}
