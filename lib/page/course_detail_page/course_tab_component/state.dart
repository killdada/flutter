import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';

class CourseTabState implements Cloneable<CourseTabState> {
  CatalogsModel courseTabData;
  @override
  CourseTabState clone() {
    return CourseTabState()..courseTabData = courseTabData;
  }
}
