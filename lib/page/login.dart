import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/widget/clear_text_field.dart';

import 'package:fluro/fluro.dart';
import 'package:myapp/router/application.dart';

class Login extends StatefulWidget {
  @override
  State createState() => new LoginState();
}

class LoginState extends State<Login> {
  bool showPwd = false;
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                  fontSize: AppSize.sp(40.0),
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
                  fontSize: AppSize.sp(25.0),
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
                      '去逛逛',
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
      height: AppSize.height(140.0),
      alignment: Alignment.center,
      decoration: InputStyles.underlineDecoration,
      child: ClearTextField(
        controller: _usernameController,
        onChanged: (input) {
          if (input.isNotEmpty) {}
        },
        style: TextStyles.style,
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
      height: AppSize.height(140.0),
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
              style: TextStyles.style,
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
              width: AppSize.width(80.0),
              height: AppSize.width(80.0),
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
      onPressed: () {},
      child: Text(
        '登录',
        style: TextStyle(
          fontSize: Dimens.sp_30,
        ),
      ),
      padding: EdgeInsets.all(AppSize.width(15.0)),
      color: Colors.blue,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
    );
  }

  void _doLogin() {}
}
