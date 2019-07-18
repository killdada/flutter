import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CourseDetailState> buildReducer() {
  return asReducer(
    <Object, Reducer<CourseDetailState>>{
      CourseDetailAction.action: _onAction,
    },
  );
}

CourseDetailState _onAction(CourseDetailState state, Action action) {
  final CourseDetailState newState = state.clone();
  return newState;
}
