import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchHeaderAction { onCancel, onDoSearch }

class SearchHeaderActionCreator {
  static Action onCancel() {
    return const Action(SearchHeaderActionCreator.onCancel);
  }

  static Action onDoSearch(String key) {
    return Action(SearchHeaderAction.onDoSearch, payload: key);
  }
}
