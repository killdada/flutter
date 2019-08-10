import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PptAction { action }

class PptActionCreator {
  static Action onAction() {
    return const Action(PptAction.action);
  }
}
