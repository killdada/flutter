import 'package:fish_redux/fish_redux.dart';
import 'action.dart';
import 'state.dart';

import 'package:fluro/fluro.dart';
import 'package:myapp/router/application.dart';
import 'package:myapp/router/routers.dart';

Effect<SearchState> buildEffect() {
  return combineEffects(<Object, Effect<SearchState>>{
    SearchAction.onClickSearch: _gotoSearchPage,
  });
}

void _gotoSearchPage(Action action, Context<SearchState> ctx) {
  Application.router.navigateTo(
    ctx.context,
    Routes.search,
    transition: TransitionType.fadeIn,
  );
}
