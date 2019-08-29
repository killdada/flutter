import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AudioState> buildReducer() {
  return asReducer(
    <Object, Reducer<AudioState>>{
      AudioAction.changePosition: _changePosition,
      AudioAction.changeCollect: _changeCollect,
    },
  );
}

AudioState _changePosition(AudioState state, Action action) {
  final AudioState newState = state.clone();
  newState.videoEventData.position = action.payload;
  return newState;
}

AudioState _changeCollect(AudioState state, Action action) {
  final AudioState newState = state.clone();
  newState.collected = !newState.collected;
  return newState;
}
