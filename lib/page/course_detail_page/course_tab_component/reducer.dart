import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CourseTabState> buildReducer() {
  return asReducer(
    <Object, Reducer<CourseTabState>>{
      CourseTabAction.action: _onAction,
    },
  );
}

CourseTabState _onAction(CourseTabState state, Action action) {
  final CourseTabState newState = state.clone();
  return newState;
}
