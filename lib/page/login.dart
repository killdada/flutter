import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  State createState() => new LoginState();
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('登录'),
    );
  }
}
