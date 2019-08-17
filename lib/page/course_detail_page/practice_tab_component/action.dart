import 'package:fish_redux/fish_redux.dart';


enum PracticeTabAction { action }

class PracticeTabActionCreator {
  static Action onAction() {
    return const Action(PracticeTabAction.action);
  }
}
