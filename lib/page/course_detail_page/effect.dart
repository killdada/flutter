import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:myapp/common/dao/course_detail_dao.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/page/course_detail_page/page.dart';
import 'action.dart';
import 'state.dart';

import 'package:myapp/common/event/event_bus.dart';
import 'package:myapp/common/event/video_event.dart';

Effect<CourseDetailState> buildEffect() {
  return combineEffects(<Object, Effect<CourseDetailState>>{
    Lifecycle.initState: _init,
    CourseDetailAction.onFetchDetail: _onFetchDetail,
  });
}

void _init(Action action, Context<CourseDetailState> ctx) async {
  final TickerProvider tickerProvider =
      ctx.stfState as CourseDetailStateKeepAliveStf;
  TabController tabController = TabController(vsync: tickerProvider, length: 2);
  CourseDetailModel detail =
      await CourseDetailDao.getCourseDetail(ctx.state.courseId);
  ctx.dispatch(CourseDetailActionCreator.initData(detail, tabController));
  MyEventBus.event.on<VideoEvent>().listen((event) {
    ctx.dispatch(CourseDetailActionCreator.changeVideoEvent(event));
  });
}

void _onFetchDetail(Action action, Context<CourseDetailState> ctx) async {
  final TickerProvider tickerProvider =
      ctx.stfState as CourseDetailStateKeepAliveStf;
  TabController tabController = TabController(vsync: tickerProvider, length: 2);
  CourseDetailModel detail =
      await CourseDetailDao.getCourseDetail(ctx.state.courseId);
  ctx.dispatch(CourseDetailActionCreator.initData(detail, tabController));
}
