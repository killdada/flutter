import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:myapp/router/application.dart';

import 'package:myapp/common/utils/data_utils.dart';
import 'package:myapp/common/constant/theme.dart';
import 'package:myapp/common/model/userinfo.dart';

class My extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyPageState();
  }
}

class MyPageState extends State<My> {
  static const double IMAGE_ICON_WIDTH = 30.0;
  static const double ARROW_ICON_WIDTH = 16.0;

  Color themeColor = ThemeUtils.currentColorTheme;

  var titles = ["我的消息", "阅读记录", "我的博客", "我的问答", "我的活动", "我的团队", "邀请好友"];
  var imagePaths = [
    "assets/images/my/ic_my_message.png",
    "assets/images/my/ic_my_blog.png",
    "assets/images/my/ic_my_blog.png",
    "assets/images/my/ic_my_question.png",
    "assets/images/my/ic_discover_pos.png",
    "assets/images/my/ic_my_team.png",
    "assets/images/my/ic_my_recommend.png"
  ];
  var icons = [];
  var userAvatar;
  var userName;
  var titleTextStyle = TextStyle(fontSize: 16.0);
  var rightArrowIcon = Image.asset(
    'assets/images/ic_arrow_right.png',
    width: ARROW_ICON_WIDTH,
    height: ARROW_ICON_WIDTH,
  );

  MyPageState() {
    for (int i = 0; i < imagePaths.length; i++) {
      icons.add(getIconImage(imagePaths[i]));
    }
  }

  @override
  void initState() {
    super.initState();
    _showUserInfo();
  }

  _showUserInfo() async {
    UserInfo userInfo = await DataUtils.getUserInfo();
    if (userInfo != null) {
      print(userInfo.name);
      setState(() {
        userAvatar = userInfo.avatar;
        userName = userInfo.name;
      });
    } else {
      setState(() {
        userAvatar = null;
        userName = null;
      });
    }
  }

  Widget getIconImage(path) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
      child:
          Image.asset(path, width: IMAGE_ICON_WIDTH, height: IMAGE_ICON_WIDTH),
    );
  }

  @override
  Widget build(BuildContext context) {
    var listView = ListView.builder(
      itemCount: titles.length * 2,
      itemBuilder: (context, i) => renderRow(i),
    );
    return listView;
  }

  // 获取用户信息
  getUserInfo() async {
    String accessToken = await DataUtils.getAccessToken();
    Map<String, String> params = Map();
    params['access_token'] = accessToken;
    // NetUtils.get(Api.userInfo, params: params).then((data) {
    //   if (data != null) {
    //     var map = json.decode(data);
    //     setState(() {
    //       userAvatar = map['avatar'];
    //       userName = map['name'];
    //     });
    //     DataUtils.saveUserInfo(map);
    //   }
    // });
  }

  _login() async {
    Application.router
        .navigateTo(context, "/counter", transition: TransitionType.native)
        .then((result) {});
    // // 打开登录页并处理登录成功的回调
    // final result =
    //     await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //   return NewLoginPage();
    // }));
    // // result为"refresh"代表登录成功
    // if (result != null && result == "refresh") {
    //   // 刷新用户信息
    //   getUserInfo();
    //   // 通知动弹页面刷新
    //   Constants.eventBus.fire(LoginEvent());
    // }
  }

  _showUserInfoDetail() {}

  renderRow(i) {
    if (i == 0) {
      var avatarContainer = Container(
        color: themeColor,
        height: 200.0,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              userAvatar == null
                  ? Image.asset(
                      "assets/images/ic_avatar_default.png",
                      width: 60.0,
                    )
                  : Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: NetworkImage(userAvatar), fit: BoxFit.cover),
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                    ),
              Text(
                userName == null ? "点击头像登录" : userName,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ],
          ),
        ),
      );
      return GestureDetector(
        onTap: () {
          DataUtils.isLogin().then((isLogin) {
            if (isLogin) {
              // 已登录，显示用户详细信息
              _showUserInfoDetail();
            } else {
              // 未登录，跳转到登录页面
              _login();
            }
          });
        },
        child: avatarContainer,
      );
    }
    --i;
    if (i.isOdd) {
      return Divider(
        height: 1.0,
      );
    }
    i = i ~/ 2;
    String title = titles[i];
    var listItemContent = Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      child: Row(
        children: <Widget>[
          icons[i],
          Expanded(
              child: Text(
            title,
            style: titleTextStyle,
          )),
          rightArrowIcon
        ],
      ),
    );
    return InkWell(
      child: listItemContent,
      onTap: () {
        _handleListItemClick(title);
      },
    );
  }

  _showLoginDialog() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text('提示'),
            content: Text('没有登录，现在去登录吗？'),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  '取消',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  '确定',
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _login();
                },
              )
            ],
          );
        });
  }

  _handleListItemClick(String title) {
    DataUtils.isLogin().then((isLogin) {
      if (!isLogin) {
        // 未登录
        _showLoginDialog();
      } else {
        print('goto>>');
      }
    });
  }
}
