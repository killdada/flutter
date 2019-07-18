import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<TabbarState> buildReducer() {
  return asReducer(
    <Object, Reducer<TabbarState>>{
      TabbarAction.action: _onAction,
    },
  );
}

TabbarState _onAction(TabbarState state, Action action) {
  final TabbarState newState = state.clone();
  return newState;
}
