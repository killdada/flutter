import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/event/video_event.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';

class CourseTabState implements Cloneable<CourseTabState> {
  CatalogsModel courseTabData;
  CourseDetailModel courseDetail;
  bool showAll;
  int pptIndex;
  VideoEvent videoEventData;

  @override
  CourseTabState clone() {
    return CourseTabState()
      ..videoEventData = videoEventData
      ..courseTabData = courseTabData
      ..showAll = showAll
      ..pptIndex = pptIndex
      ..courseDetail = courseDetail;
  }
}
