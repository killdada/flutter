import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PracticeTabState> buildReducer() {
  return asReducer(
    <Object, Reducer<PracticeTabState>>{
      PracticeTabAction.initTopicDetail: _initTopicDetail,
      PracticeTabAction.changeShowDesc: _changeShowDesc,
    },
  );
}

PracticeTabState _changeShowDesc(PracticeTabState state, Action action) {
  final PracticeTabState newState = state.clone();
  newState.isShowDetailDesc = !newState.isShowDetailDesc;
  return newState;
}

PracticeTabState _initTopicDetail(PracticeTabState state, Action action) {
  final PracticeTabState newState = state.clone();
  newState.topicDetail = action.payload;
  return newState;
}
