import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<SearchHeaderState> buildReducer() {
  return asReducer(
    <Object, Reducer<SearchHeaderState>>{
      // SearchHeaderAction.setInputState: _onsetInputState,
    },
  );
}

SearchHeaderState _onsetInputState(SearchHeaderState state, Action action) {
  final SearchHeaderState newState = state.clone();
  return newState;
}
