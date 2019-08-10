import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CourseCatalogAction { action }

class CourseCatalogActionCreator {
  static Action onAction() {
    return const Action(CourseCatalogAction.action);
  }
}
