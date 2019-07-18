import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CourseListState> buildReducer() {
  return asReducer(
    <Object, Reducer<CourseListState>>{
      CourseListAction.action: _onAction,
    },
  );
}

CourseListState _onAction(CourseListState state, Action action) {
  final CourseListState newState = state.clone();
  return newState;
}
