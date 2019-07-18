import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum TabbarAction { action }

class TabbarActionCreator {
  static Action onAction() {
    return const Action(TabbarAction.action);
  }
}
