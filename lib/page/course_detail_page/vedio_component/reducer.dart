import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<VedioState> buildReducer() {
  return asReducer(
    <Object, Reducer<VedioState>>{
      VedioAction.action: _onAction,
    },
  );
}

VedioState _onAction(VedioState state, Action action) {
  final VedioState newState = state.clone();
  return newState;
}
