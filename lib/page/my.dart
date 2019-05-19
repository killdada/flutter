import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:myapp/router/application.dart';

class My extends StatefulWidget {
  @override
  State createState() => new MyState();
}

class MyState extends State<My> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new RaisedButton(
        onPressed: () {
          print(
              '点击3333333333333333333333333333333333333333333333333333333333333333333333333333333');
          Application.router
              .navigateTo(context, "/counter",
                  transition: TransitionType.native)
              .then((result) {});
        },
        color: Colors.black, //按钮的背景颜色
        padding: EdgeInsets.all(50.0), //按钮距离里面内容的内边距
        child: new Text('我的'),
        textColor: Colors.white, //文字的颜色
        textTheme: ButtonTextTheme.normal, //按钮的主题
        onHighlightChanged: (bool b) {
          //水波纹高亮变化回调
        },
        disabledTextColor: Colors.black54, //按钮禁用时候文字的颜色
        disabledColor: Colors.black54, //按钮被禁用的时候显示的颜色
        highlightColor: Colors.yellowAccent, //点击或者toch控件高亮的时候显示在控件上面，水波纹下面的颜色
        splashColor: Colors.white, //水波纹的颜色
        colorBrightness: Brightness.light, //按钮主题高亮
        elevation: 10.0, //按钮下面的阴影
        highlightElevation: 10.0, //高亮时候的阴影
        disabledElevation: 10.0, //按下的时候的阴影
//              shape:,//设置形状  LearnMaterial中有详解
      ),
    );
  }
}
