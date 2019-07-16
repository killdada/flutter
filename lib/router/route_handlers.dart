import 'package:myapp/page/my.dart';
import 'package:myapp/page/login.dart';
import 'package:myapp/page/course.dart';
import 'package:myapp/page/learn_rank.dart';
import 'package:myapp/page/learn_record.dart';
import 'package:myapp/page/page_container.dart';

import 'package:myapp/common/utils/fluro_convert_util.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// import 'package:myapp/common//fluro_convert_util.dart';

// Handler detailRouterHandler = Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   return Detail(
//       title: FluroConvertUtils.fluroCnParamsDecode(params["title"]?.first));
// });

Handler homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PageContainer();
});

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

Handler learnRankRouterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LearnRank(
      title: FluroConvertUtils.fluroCnParamsDecode(params["title"]?.first));
});

Handler learnRecordRouterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LearnRecord();
});
