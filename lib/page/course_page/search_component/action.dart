import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchAction { onClickSearch }

class SearchActionCreator {
  static Action gotoSearchPage() {
    return const Action(SearchAction.onClickSearch);
  }
}
