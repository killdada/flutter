import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/course_detail_topic_model.dart';

enum PracticeTabAction {
  initTopicDetail,
  onChangeSortType,
  changeSortType,
  changeShowDesc,
  onFetchData
}

class PracticeTabActionCreator {
  static Action onFetchData() {
    return Action(PracticeTabAction.onFetchData);
  }

  static Action initTopicDetail(CourseDetailTopicModel payload) {
    return Action(PracticeTabAction.initTopicDetail, payload: payload);
  }

  static Action onChangeSortType(String payload) {
    return Action(PracticeTabAction.onChangeSortType, payload: payload);
  }

  static Action changeSortType(String payload) {
    return Action(PracticeTabAction.changeSortType, payload: payload);
  }

  static Action changeShowDesc() {
    return const Action(PracticeTabAction.changeShowDesc);
  }
}
