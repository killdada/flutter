import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:myapp/common/event/event_bus.dart';
import 'package:myapp/common/event/video_event.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<CourseDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<CourseDetailState>>{
      CourseDetailAction.initData: _initData,
      CourseDetailAction.changeCurrentTab: _changeCurrentTab,
      CourseDetailAction.changeShowAll: _changeShowAll,
      CourseDetailAction.changeIndex: _changeIndex,
      CourseDetailAction.changeCollect: _changeCollect,
      CourseDetailAction.changePptIndex: _changePptIndex,
      CourseDetailAction.changeVideoEvent: _changeVideoEvent,
    },
  );
}

CourseDetailState _changeVideoEvent(CourseDetailState state, Action action) {
  final CourseDetailState newState = state.clone();
  newState.videoEventData = action.payload;
  return newState;
}

CourseDetailState _initData(CourseDetailState state, Action action) {
  final CourseDetailState newState = state.clone();
  Map data = action.payload;
  CourseDetailModel detail = data['detail'];
  TabController tabController = data['tabController'];
  newState.courseDetail = detail;
  newState.tabController = tabController;
  if (detail.catalogs.isNotEmpty) {
    newState.currentCatalog = detail.catalogs[0];
  }
  newState.collected = detail.collected == 1;
  return newState;
}

CourseDetailState _changeCurrentTab(CourseDetailState state, Action action) {
  final CourseDetailState newState = state.clone();
  if (newState.currentCatalog !=  action.payload) {
  newState.currentCatalog = action.payload;
    newState.pptIndex = 0;
    MyEventBus.event.fire(ChangePlayUrl(newState.currentCatalog.videoUrl));
  }
  return newState;
}

CourseDetailState _changeShowAll(CourseDetailState state, Action action) {
  final CourseDetailState newState = state.clone();
  newState.showAll = true;
  return newState;
}

CourseDetailState _changeCollect(CourseDetailState state, Action action) {
  final CourseDetailState newState = state.clone();
  newState.collected = !newState.collected;
  return newState;
}

CourseDetailState _changeIndex(CourseDetailState state, Action action) {
  final CourseDetailState newState = state.clone();
  if (newState.index == 0) {
    newState.index = 1;
  } else {
    newState.index = 0;
  }
  return newState;
}

CourseDetailState _changePptIndex(CourseDetailState state, Action action) {
  final CourseDetailState newState = state.clone();
  int index = action.payload['index'];
  bool needSeek =  action.payload['needSeek'];
  newState.pptIndex = index;
  MyEventBus.event.fire(ChangePptIndex(newState.currentCatalog.ppt[index], needSeek));
  return newState;
}
