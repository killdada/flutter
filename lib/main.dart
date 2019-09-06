import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 路由
import 'package:fluro/fluro.dart';
import 'package:myapp/common/utils/index.dart';
import 'package:myapp/router/routers.dart';
import 'package:myapp/router/application.dart';

import 'package:flutter/services.dart';

// 主题的utils
import 'package:myapp/common/constant/theme.dart';
import 'package:myapp/common/constant/style.dart';

// // APP整个的页面布局的container
// import 'package:myapp/page/page_container.dart';
import 'package:myapp/page/splash_page.dart';

import 'package:myapp/common/event/event_bus.dart';
import 'package:myapp/common/event/http_error_event.dart';
import 'package:myapp/common/http/code.dart';

import 'common/blocs/application_bloc.dart';
import 'common/blocs/bloc_provider.dart';

import 'package:fluwx/fluwx.dart' as fluwx;

void main() {
  runZoned(() {
    runApp(BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
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

final Connectivity _connectivity = AppUtil.connectivity;

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
    _initAsync();
    _initListen();
    _initFluwx();
  }

  void _initAsync() async {
    await AppUtil.init();
  }

  void _initListen() {
    final ApplicationBloc bloc = BlocProvider.of<ApplicationBloc>(context);
    bloc.appEventStream.listen((value) {
      print('app event: $value');
    });
    initConnectivity();
    _connectivity?.onConnectivityChanged?.listen((status) {
      if (status != AppUtil.connectivityStatus) {
        print('status:$status');
        AppUtil.updateConnectivityStatus(status);
      }
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
      AppUtil.updateConnectivityStatus(result);
    } on PlatformException catch (e) {
      print(e.toString());
    }
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return;
    }
  }

  _initFluwx() async {
    await fluwx.register(
        appId: "wxc8e6a2037e0e55f0",
        doOnAndroid: true,
        doOnIOS: true,
        enableMTA: false);
    var result = await fluwx.isWeChatInstalled();
    print("is installed $result");
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
