import 'dart:async';

import 'package:flutter/material.dart';

// 路由
import 'package:fluro/fluro.dart';
import 'package:myapp/router/routers.dart';
import 'package:myapp/router/application.dart';

// mobx测试
import 'package:provider/provider.dart';
import 'package:myapp/store/counter.dart';

// 主题的utils
import 'package:myapp/common/constant/theme.dart';

// APP整个的页面布局的container
import 'package:myapp/page/page_container.dart';

void main() {
  runZoned(() {
    runApp(MultiProvider(
      // 装载共用同一个实例的store
      providers: [
        Provider<Counter>(
          builder: (_) => Counter(),
        )
      ],
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

class MyApp extends StatelessWidget {
  MyApp() {
    // 构造函数里面配置初始化路由，通过MaterialApp onGenerateRoute进行挂载
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'myapp',
      theme: ThemeData(
        primaryColor: ThemeUtils.currentColorTheme,
      ),
      home: new PageContainer(),
      onGenerateRoute: Application.router.generator,
    );
  }
}
