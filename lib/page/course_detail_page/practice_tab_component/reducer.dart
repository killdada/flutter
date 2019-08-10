import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PracticeTabState> buildReducer() {
  return asReducer(
    <Object, Reducer<PracticeTabState>>{
      PracticeTabAction.action: _onAction,
    },
  );
}

PracticeTabState _onAction(PracticeTabState state, Action action) {
  final PracticeTabState newState = state.clone();
  return newState;
}
