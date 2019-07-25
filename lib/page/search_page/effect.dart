import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

Effect<SearchState> buildEffect() {
  return combineEffects(<Object, Effect<SearchState>>{
    SearchAction.changeIndexedStack: _onchangeIndexedStack,
  });
}

void _onchangeIndexedStack(Action action, Context<SearchState> ctx) {
  ctx.dispatch(SearchActionCreator.changeIndexedStack(action.payload));
}
