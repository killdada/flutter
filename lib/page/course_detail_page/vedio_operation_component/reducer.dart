import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<VedioOperationState> buildReducer() {
  return asReducer(
    <Object, Reducer<VedioOperationState>>{
      // VedioOperationAction.action: _onAction,
    },
  );
}

VedioOperationState _onAction(VedioOperationState state, Action action) {
  final VedioOperationState newState = state.clone();
  return newState;
}
