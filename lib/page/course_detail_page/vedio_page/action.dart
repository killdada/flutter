import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/widget/video_player_gather.dart';

//TODO replace with your own action
enum VedioAction {
  changeFullScreen,
  changeToggleScreen,
  changeViweMode,
  changeResumePlay,
  changeVideo
}

class VedioActionCreator {
  static Action changeVideo(String url) {
    return Action(VedioAction.changeVideo, payload: url);
  }

  static Action changeFullScreen(bool value) {
    return Action(VedioAction.changeFullScreen, payload: value);
  }

  static Action changeToggleScreen(bool value) {
    return Action(VedioAction.changeToggleScreen, payload: value);
  }

  static Action changeViweMode(bool value) {
    return Action(VedioAction.changeViweMode, payload: value);
  }

  static Action changeResumePlay(bool value) {
    return Action(VedioAction.changeResumePlay, payload: value);
  }
}
