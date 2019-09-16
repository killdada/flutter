import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CourseDownloadState> buildReducer() {
  return asReducer(
    <Object, Reducer<CourseDownloadState>>{
      // CourseDownloadAction.action: _onAction,
    },
  );
}

CourseDownloadState _onAction(CourseDownloadState state, Action action) {
  final CourseDownloadState newState = state.clone();
  return newState;
}
