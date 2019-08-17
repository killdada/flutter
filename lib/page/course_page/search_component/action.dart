import 'package:fish_redux/fish_redux.dart';


enum SearchAction { onClickSearch }

class SearchActionCreator {
  static Action gotoSearchPage() {
    return const Action(SearchAction.onClickSearch);
  }
}
