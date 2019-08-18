
import 'package:myapp/page/course_detail_page/audio_page/page.dart';
import 'package:myapp/page/my.dart';
import 'package:myapp/page/login.dart';
import 'package:myapp/page/course.dart';
import 'package:myapp/page/learn_rank.dart';
import 'package:myapp/page/learn_record.dart';
import 'package:myapp/page/page_container.dart';
import 'package:myapp/page/search_page/page.dart';
import 'package:myapp/page/course_detail_page/page.dart';
import 'package:myapp/page/download_page.dart';
import 'package:myapp/page/feedback_page.dart';
import 'package:myapp/page/collection_page.dart';

import 'package:myapp/common/utils/fluro_convert_util.dart';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

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

Handler searchRouterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SearchPage().buildPage(null);
});

Handler courseDetailRouterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CourseDetailPage()
      .buildPage({'courseId': int.parse(params["courseId"]?.first)});
});

Handler downLoadRouterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DownloadPage();
});

Handler feedbackRouterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return FeedbackPage();
});

Handler collectionRouterHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CollectionPage();
});
