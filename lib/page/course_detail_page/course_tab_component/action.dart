import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CourseTabAction { action }

class CourseTabActionCreator {
  static Action onAction() {
    return const Action(CourseTabAction.action);
  }
}
