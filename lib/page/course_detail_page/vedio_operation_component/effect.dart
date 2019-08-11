import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/constant/constant.dart';
import 'action.dart';
import 'state.dart';

Effect<VedioOperationState> buildEffect() {
  return combineEffects(<Object, Effect<VedioOperationState>>{
    VedioOperationAction.onClickItem: _onClickItem,
  });
}

void _onClickItem(Action action, Context<VedioOperationState> ctx) {
  ActionType type = action.payload;
  switch (type) {
    case ActionType.share:
      break;
    case ActionType.download:
      break;
    case ActionType.collection:
      break;
    case ActionType.feedback:
      break;
    default:
  }
}
