import 'package:myapp/page/my.dart';
import 'package:myapp/page/login.dart';
import 'package:myapp/page/course.dart';
import 'package:myapp/page/learn_rank.dart';
import 'package:myapp/page/learn_record.dart';

/// 测试mobx
import 'package:myapp/store/counter_widgets.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// import 'package:myapp/common//fluro_convert_util.dart';

// Handler detailRouterHandler = Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   return Detail(
//       title: FluroConvertUtils.fluroCnParamsDecode(params["title"]?.first));
// });

Handler rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return My();
});

Handler myRouteHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return My();
});

Handler loginRouterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Login();
});

Handler courseRouterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Course();
});

Handler counterRouterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CounterExample();
});

Handler learnRankRouterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LearnRank();
});

Handler learnRecordRouterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LearnRecord();
});
