

import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:myapp/common/constant/constant.dart';
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

 void _jumpPPTPage( Context<CourseDetailState> ctx,int _startTime) {
   try {
      CourseDetailState state = ctx.state;
    if (_startTime <= 0) return;
    int startTime = _startTime + 1; //解决小数点导致时间计算有误,比如seek to 20秒，回调会给出19秒
    int _lastPptIndex = state.pptIndex;
    PptModel _lastPpt =  state.currentCatalog.ppt[_lastPptIndex];
    if ( _lastPpt.timeStart == null ||  _lastPpt.timeEnd == null) {
      print('ppt时间不合法,请检查接口和对应后台');
      return;
    }
    if (startTime >= _lastPpt.timeStart && startTime < _lastPpt.timeEnd) {
      // 已经在此页，不需要翻页
      print('已经在此页，不需要翻页');
    } else {
      for (int i = 0; i < state.currentCatalog.ppt.length; i++) {
        PptModel _p = state.currentCatalog.ppt[i];
        int start = _p.timeStart;
        int end = _p.timeEnd;
        if ( _lastPpt.timeStart == null ||  _lastPpt.timeEnd == null) {
          print('ppt时间不合法,请检查接口和对应后台');
          break;
        }
        if (startTime >= start && startTime < end) {
          print('video time:$startTime');
          if (_lastPptIndex < i) {
            print('往后加页 start:$start end:$end 准备跳转ppt到$i页');
          } else {
            print('往前减页 start:$start end:$end 准备跳转ppt到$i页');
          }
          ctx.dispatch(CourseDetailActionCreator.changePptIndex(i, needSeek: false));
          break;
        }
      }
    }
   } catch (e) {
   }
  
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
  MyEventBus.event.on<JumpPPtWithTime>().listen((event) {
   _jumpPPTPage(ctx, event.time);
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
