import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AudioAction { changePosition, changeCollect }

class AudioActionCreator {
  static Action changePosition(Duration position) {
    return Action(AudioAction.changePosition, payload: position);
  }

  static Action changeCollect() {
    return const Action(AudioAction.changeCollect);
  }
}
