

import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<VedioOperationState> buildReducer() {
  return asReducer(
    <Object, Reducer<VedioOperationState>>{
      VedioOperationAction.changeCollect: _changeCollect,
    },
  );
}

VedioOperationState _changeCollect(VedioOperationState state, Action action) {
  final VedioOperationState newState = state.clone();
  newState.collected = !newState.collected;
  return newState;
}
