import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum VedioOperationAction { action }

class VedioOperationActionCreator {
  static Action onAction() {
    return const Action(VedioOperationAction.action);
  }
}
