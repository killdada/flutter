import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluro/fluro.dart';
import 'package:myapp/router/application.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/widget/clear_text_field.dart';
import 'package:myapp/common/dao/user_dao.dart';
import 'package:myapp/widget/loading_dialog.dart';

class Login extends StatefulWidget {
  @override
  State createState() => new LoginState();
}

class LoginState extends State<Login> {
  bool showPwd = true;
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _content();
  }

  Widget _content() {
    return new Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        top: true,
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(
            AppSize.width(30.0),
            AppSize.height(100.0),
            AppSize.width(30.0),
            AppSize.height(50.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '域账号密码登录',
                style: TextStyle(
                  fontSize: AppSize.sp(56.0),
                  color: Colours.textFirst,
                ),
              ),
              SizedBox(
                height: AppSize.height(20.0),
              ),
              Text(
                '域帐号格式如：Lisw01',
                style: TextStyle(
                  color: Colours.textSecond,
                  fontSize: AppSize.sp(32.0),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: AppSize.height(165.0), bottom: AppSize.height(27.0)),
                child: _usernameInput(),
              ),
              _pwdInput(),
              Container(
                margin: EdgeInsets.only(top: AppSize.height(120.0)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _loginBtn(),
                    )
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Application.router.navigateTo(
                      context,
                      '/home',
                      replace: true,
                      transition: TransitionType.native,
                    );
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      '先逛逛',
                      style: TextStyle(
                        color: Colours.textThird,
                        fontSize: AppSize.sp(25.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _usernameInput() {
    return Container(
      height: AppSize.height(120.0),
      alignment: Alignment.center,
      decoration: InputStyles.underlineDecoration,
      child: ClearTextField(
        controller: _usernameController,
        onChanged: (input) {
          if (input.isNotEmpty) {}
        },
        style: TextStyle(
          fontSize: Dimens.sp_30,
          color: Colours.textFirst,
          fontWeight: FontWeight.normal,
        ),
        keyboardType: TextInputType.emailAddress,
        inputFormatters: [
          BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]")),
        ],
        autofocus: false,
        maxLines: 1,
        maxLength: 15,
        decoration: InputStyles.inputDecoration.copyWith(hintText: '请输入账号'),
        textInputAction: TextInputAction.next,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
      ),
    );
  }

  Widget _pwdInput() {
    return Container(
      height: AppSize.height(120.0),
      alignment: Alignment.center,
      decoration: InputStyles.underlineDecoration,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: ClearTextField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              obscureText: !showPwd,
              style: TextStyle(
                fontSize: Dimens.sp_30,
                color: Colours.textFirst,
                fontWeight: FontWeight.normal,
              ),
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [
                BlacklistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]")),
              ],
              maxLines: 1,
              maxLength: 15,
              decoration:
                  InputStyles.inputDecoration.copyWith(hintText: '请输入密码'),
              textInputAction: TextInputAction.go,
              onSubmitted: (input) => _doLogin(),
            ),
          ),
          InkWell(
            child: Container(
              width: AppSize.width(60.0),
              height: AppSize.width(60.0),
              child: Image.asset(
                showPwd
                    ? 'assets/images/icon_pwd_show.png'
                    : 'assets/images/icon_pwd_hide.png',
              ),
            ),
            onTap: () {
              setState(() {
                showPwd = !showPwd;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _loginBtn() {
    return FlatButton(
      onPressed: () {
        _doLogin();
      },
      child: Text(
        '登录',
        style: TextStyle(
          fontSize: Dimens.sp_32,
        ),
      ),
      padding: EdgeInsets.all(AppSize.width(20.0)),
      color: Colors.blue,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
    );
  }

  void _doLogin() async {
    var username = _usernameController.text;
    var pwd = _passwordController.text;
    if (username.isEmpty) {
      Fluttertoast.showToast(msg: '请输入账号');
      return;
    }
    if (pwd.isEmpty) {
      Fluttertoast.showToast(msg: '请输入密码');
      return;
    }
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return LoadingDialog(
            text: '正在登录',
          );
        });
    print('登录');
    try {
      await UserDao.login(username, pwd);
      Application.router.navigateTo(
        context,
        '/home',
        replace: true,
        transition: TransitionType.native,
      );
    } catch (e) {
      print('登录失败$e');
      Fluttertoast.showToast(msg: e);
      Navigator.pop(context);
    }
  }
}
