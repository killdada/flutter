import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum VedioAction { action }

class VedioActionCreator {
  static Action onAction() {
    return const Action(VedioAction.action);
  }
}
