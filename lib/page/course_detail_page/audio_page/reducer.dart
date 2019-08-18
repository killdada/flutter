import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AudioState> buildReducer() {
  return asReducer(
    <Object, Reducer<AudioState>>{
      AudioAction.changePosition: _changePosition,
    },
  );
}

AudioState _changePosition(AudioState state, Action action) {
  final AudioState newState = state.clone();
  newState.videoEventData.position = action.payload;
  return newState;
}
