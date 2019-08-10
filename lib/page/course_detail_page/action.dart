import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/index.dart';

//TODO replace with your own action
enum CourseDetailAction { onFetchDetail, detailDataLoaded }

class CourseDetailActionCreator {
  static Action onFetchDetail() {
    return const Action(CourseDetailAction.onFetchDetail);
  }

  static Action detailDataLoaded(CourseDetailModel detail) {
    return Action(CourseDetailAction.detailDataLoaded, payload: detail);
  }
}
