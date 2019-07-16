import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:myapp/router/route_handlers.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String my = "/my";
  static String login = "/login";
  static String course = "/course";
  static String counter = "/counter";
  static String learnRank = "/learnrank";
  static String learnRecord = "/learnrecord";

  // 对路由进行配置，define进行定义handler是回调
  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("该路由没有找到");
    });
    router.define(root, handler: rootHandler);
    router.define(home, handler: homeHandler);
    router.define(my, handler: myRouteHandler);
    router.define(login, handler: loginRouterHandler);
    router.define(course, handler: courseRouterHandler);
    router.define(learnRank, handler: learnRankRouterHandler);
    router.define(learnRecord, handler: learnRecordRouterHandler);
  }
}
