import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CourseListAction { action }

class CourseListActionCreator {
  static Action onAction() {
    return const Action(CourseListAction.action);
  }
}
