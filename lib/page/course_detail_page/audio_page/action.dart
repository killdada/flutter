import 'package:audioplayers/audioplayers.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/index.dart';

enum AudioAction {
  changePosition,
  changeCollect,
  onSeekTo,
  onChangePlayUrl,
  onPause,
  onResume,
  changeCurrentCatalog,
  changeAudioPlayerState,
  changeAudioDuration
}

class AudioActionCreator {
  static Action changeAudioPlayerState(AudioPlayerState state) {
    return Action(AudioAction.changeAudioPlayerState, payload: state);
  }

  static Action changeAudioDuration(Duration duration) {
    return Action(AudioAction.changeAudioDuration, payload: duration);
  }

  static Action changePosition(Duration position) {
    return Action(AudioAction.changePosition, payload: position);
  }

  static Action changeCollect() {
    return const Action(AudioAction.changeCollect);
  }

  static Action onPause() {
    return const Action(AudioAction.onPause);
  }

  static Action onResume() {
    return const Action(AudioAction.onResume);
  }

  static Action onSeekTo(Duration position) {
    return Action(AudioAction.onSeekTo, payload: position);
  }

  static Action changeCurrentCatalog(CatalogsModel catalog) {
    return Action(AudioAction.changeCurrentCatalog, payload: catalog);
  }

  static Action onChangePlayUrl(CatalogsModel catalog) {
    return Action(AudioAction.onChangePlayUrl, payload: catalog);
  }
}
