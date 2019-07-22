import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';
import 'dart:developer';

import 'package:myapp/common/model/course/course.dart';

Reducer<TabbarState> buildReducer() {
  return asReducer(
    <Object, Reducer<TabbarState>>{
      TabbarAction.loadData: _onLoadData,
    },
  );
}

TabbarState _onLoadData(TabbarState state, Action action) {
  final TabbarState newState = state.clone();
  try {
    List<CourseModel> courseList = action.payload;
    debugger();
    if (newState.categoryId != null) {
      newState.courseData['${newState.categoryId}'] = courseList;
    }
  } catch (e) {
    print('>>>>iii${e}');
  }

  return newState;
}
