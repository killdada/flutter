import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course/course.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchState>>{
      SearchAction.changeIndexedStack: _onChangeIndexedStack,
      SearchAction.onChangeIndexedStack: _onChangeIndexedStack,
      SearchAction.fetchCourseList: _onfetchCourseList,
      SearchAction.loadSearchResult: _onfetchCourseList,
    },
  );
}

SearchState _onChangeIndexedStack(SearchState state, Action action) {
  final SearchState newState = state.clone();
  newState.index = action.payload;
  return newState;
}

SearchState _onfetchCourseList(SearchState state, Action action) {
  final SearchState newState = state.clone();
  List<CourseModel> list =
      (action.payload as List).map((v) => CourseModel.fromJson(v)).toList();
  newState.courseList = list;
  return newState;
}
