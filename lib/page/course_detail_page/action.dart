import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CourseDetailAction { action }

class CourseDetailActionCreator {
  static Action onAction() {
    return const Action(CourseDetailAction.action);
  }
}
