import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchHeaderState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchHeaderState>>{
      SearchHeaderAction.action: _onAction,
    },
  );
}

SearchHeaderState _onAction(SearchHeaderState state, Action action) {
  final SearchHeaderState newState = state.clone();
  return newState;
}
