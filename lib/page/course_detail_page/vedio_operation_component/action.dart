import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/constant/constant.dart';

//TODO replace with your own action
enum VedioOperationAction { onClickItem }

class VedioOperationActionCreator {
  static Action onClickItem(ActionType type) {
    return Action(VedioOperationAction.onClickItem, payload: type);
  }
}
