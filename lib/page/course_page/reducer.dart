import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CourseState> buildReducer() {
  return asReducer(
    <Object, Reducer<CourseState>>{
      CourseAction.action: _onAction,
    },
  );
}

CourseState _onAction(CourseState state, Action action) {
  final CourseState newState = state.clone();
  return newState;
}
