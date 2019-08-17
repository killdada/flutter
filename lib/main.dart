import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 路由
import 'package:fluro/fluro.dart';
import 'package:myapp/router/routers.dart';
import 'package:myapp/router/application.dart';

// mobx测试
import 'package:provider/provider.dart';

// 主题的utils
import 'package:myapp/common/constant/theme.dart';
import 'package:myapp/common/constant/style.dart';

// // APP整个的页面布局的container
// import 'package:myapp/page/page_container.dart';
import 'package:myapp/page/splash_page.dart';

import 'package:myapp/common/event/event_bus.dart';
import 'package:myapp/common/event/http_error_event.dart';
import 'package:myapp/common/http/code.dart';

void main() {
  runZoned(() {
    runApp(MultiProvider(
      // 装载共用同一个实例的store
      providers: [],
      child: MyApp(),
    ));
    // 图片缓存个数 100
    PaintingBinding.instance.imageCache.maximumSize = 100;
    // 图片缓存大小 50m
    PaintingBinding.instance.imageCache.maximumSizeBytes = 50 << 20;
  }, onError: (Object obj, StackTrace stack) {
    // 捕获错误异常
    print(obj);
    print(stack);
  });
}

class MyApp extends StatefulWidget {
  MyApp() {
    // 构造函数里面配置初始化路由，通过MaterialApp onGenerateRoute进行挂载
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  _MyAppState createState() => _MyAppState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _MyAppState extends State<MyApp> {
  StreamSubscription stream;
  @override
  void initState() {
    super.initState();
    stream = MyEventBus.event.on<HttpErrorEvent>().listen((event) {
      errorHandleFunction(event.code, event.message);
    });
    SystemStyles.setStatusBarStyle();
  }

  @override
  void dispose() {
    super.dispose();
    if (stream != null) {
      stream.cancel();
      stream = null;
    }
  }

  errorHandleFunction(int code, message) {
    switch (code) {
      case Code.NETWORK_ERROR:
        Fluttertoast.showToast(msg: '网络错误');
        break;
      case 401:
        Fluttertoast.showToast(msg: '[401错误可能: 未授权 \\ 授权登录失败 \\ 登录过期');
        break;
      case 403:
        Fluttertoast.showToast(msg: '403权限错误');
        break;
      case 404:
        Fluttertoast.showToast(msg: '404错误');
        break;
      case Code.NETWORK_TIMEOUT:
        //超时
        Fluttertoast.showToast(msg: '请求超时');
        break;
      default:
        Fluttertoast.showToast(msg: '其他异常$message');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // AppSize.initDesignSize(context: context);
    return MaterialApp(
      title: 'myapp',
      theme: ThemeData(
        primaryColor: ThemeUtils.currentColorTheme,
      ),
      home: SplashPage(),
      onGenerateRoute: Application.router.generator,
      navigatorKey: navigatorKey,
    );
  }
}
