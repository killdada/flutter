import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course/course.dart';

import 'action.dart';
import 'state.dart';

Reducer<CourseListState> buildReducer() {
  return asReducer(
    <Object, Reducer<CourseListState>>{
      CourseListAction.loadData: _onLoadData,
    },
  );
}

CourseListState _onLoadData(CourseListState state, Action action) {
  final CourseListState newState = state.clone();
  List<CourseModel> courseList = action.payload;
  newState.courseList = courseList;
  return newState;
}
