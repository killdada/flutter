import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PptState> buildReducer() {
  return asReducer(
    <Object, Reducer<PptState>>{
      PptAction.action: _onAction,
    },
  );
}

PptState _onAction(PptState state, Action action) {
  final PptState newState = state.clone();
  return newState;
}
