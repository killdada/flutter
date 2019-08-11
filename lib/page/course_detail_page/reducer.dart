import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:myapp/common/model/course-detail/course_detail_model.dart';

import 'action.dart';
import 'state.dart';

Reducer<CourseDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<CourseDetailState>>{
      CourseDetailAction.initData: _initData,
      CourseDetailAction.changeCurrentTab: _changeCurrentTab,
    },
  );
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
  return newState;
}

CourseDetailState _changeCurrentTab(CourseDetailState state, Action action) {
  final CourseDetailState newState = state.clone();
  newState.currentCatalog = action.payload;
  return newState;
}
