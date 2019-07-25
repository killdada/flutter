import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchState>>{
      SearchAction.changeIndexedStack: _onChangeIndexedStack,
    },
  );
}

SearchState _onChangeIndexedStack(SearchState state, Action action) {
  final SearchState newState = state.clone();
  newState.index = action.payload;
  return newState;
}
