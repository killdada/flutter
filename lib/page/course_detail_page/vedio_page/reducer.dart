import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<VedioState> buildReducer() {
  return asReducer(
    <Object, Reducer<VedioState>>{
      VedioAction.changeToggleScreen: _changeToggleScreen,
      VedioAction.changeFullScreen: _changeFullScreen,
      VedioAction.changeViweMode: _changeViweMode,
      VedioAction.changeResumePlay: _changeResumePlay,
    },
  );
}

VedioState _changeResumePlay(VedioState state, Action action) {
  final VedioState newState = state.clone();
  newState.resumePlay = action.payload;
  return newState;
}

VedioState _changeViweMode(VedioState state, Action action) {
  final VedioState newState = state.clone();
  newState.isSimple = action.payload;
  return newState;
}

VedioState _changeFullScreen(VedioState state, Action action) {
  final VedioState newState = state.clone();
  newState.isFullScreen = action.payload;
  return newState;
}

VedioState _changeToggleScreen(VedioState state, Action action) {
  final VedioState newState = state.clone();
  newState.isToggleScreen = action.payload;
  return newState;
}
