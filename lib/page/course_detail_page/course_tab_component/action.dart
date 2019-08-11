import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';

//TODO replace with your own action
enum CourseTabAction { onChangeCurrentTab }

class CourseTabActionCreator {
  static Action onChangeCurrentTab(CatalogsModel catalog) {
    return Action(CourseTabAction.onChangeCurrentTab, payload: catalog);
  }
}
