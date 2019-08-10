import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PracticeTabAction { action }

class PracticeTabActionCreator {
  static Action onAction() {
    return const Action(PracticeTabAction.action);
  }
}
