import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AudioState> buildReducer() {
  return asReducer(
    <Object, Reducer<AudioState>>{
      AudioAction.changePosition: _changePosition,
      AudioAction.changeCollect: _changeCollect,
      AudioAction.changeCurrentCatalog: _changeCurrentCatalog,
      AudioAction.changeAudioPlayerState: _changeAudioPlayerState,
      AudioAction.changeAudioDuration: _changeAudioDuration,
    },
  );
}

AudioState _changeAudioPlayerState(AudioState state, Action action) {
  final AudioState newState = state.clone();
  newState.audioPlayerState = action.payload;
  return newState;
}

AudioState _changeCurrentCatalog(AudioState state, Action action) {
  final AudioState newState = state.clone();
  newState.currentCatalog = action.payload;
  newState.duration = null;
  return newState;
}

AudioState _changeAudioDuration(AudioState state, Action action) {
  final AudioState newState = state.clone();
  newState.duration = action.payload;
  return newState;
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
