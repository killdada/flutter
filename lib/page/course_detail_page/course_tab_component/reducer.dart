import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CourseTabState> buildReducer() {
  return asReducer(
    <Object, Reducer<CourseTabState>>{
      CourseTabAction.changeShowAll: _changeShowAll,
    },
  );
}

CourseTabState _changeShowAll(CourseTabState state, Action action) {
  final CourseTabState newState = state.clone();
  newState.showAll = true;
  return newState;
}
