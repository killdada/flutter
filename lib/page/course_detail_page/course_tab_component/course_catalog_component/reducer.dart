import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<CourseCatalogState> buildReducer() {
  return asReducer(
    <Object, Reducer<CourseCatalogState>>{
      CourseCatalogAction.action: _onAction,
    },
  );
}

CourseCatalogState _onAction(CourseCatalogState state, Action action) {
  final CourseCatalogState newState = state.clone();
  return newState;
}
