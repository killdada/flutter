import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum AudioAction { changePosition }

class AudioActionCreator {
  static Action changePosition(Duration position) {
    return Action(AudioAction.changePosition, payload: position);
  }
}
