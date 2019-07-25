import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchHeaderState> buildEffect() {
  return combineEffects(<Object, Effect<SearchHeaderState>>{
    SearchHeaderAction.action: _onAction,
  });
}

void _onAction(Action action, Context<SearchHeaderState> ctx) {
}
