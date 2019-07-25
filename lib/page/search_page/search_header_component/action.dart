import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum SearchHeaderAction { action }

class SearchHeaderActionCreator {
  static Action onAction() {
    return const Action(SearchHeaderAction.action);
  }
}
