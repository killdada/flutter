import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/index.dart';

class PracticeTabState implements Cloneable<PracticeTabState> {
  CourseDetailModel practiceData;
  String sortType = 'time';
  CourseDetailTopicModel topicDetail;
  bool isShowDetailDesc = false;
  @override
  PracticeTabState clone() {
    return PracticeTabState()
      ..practiceData = practiceData
      ..topicDetail = topicDetail
      ..isShowDetailDesc = isShowDetailDesc
      ..sortType = sortType;
  }
}

PracticeTabState initState(Map<String, dynamic> args) {
  return PracticeTabState()..practiceData = args['practiceData'];
}
