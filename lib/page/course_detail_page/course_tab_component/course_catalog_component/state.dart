import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';

class CourseCatalogState implements Cloneable<CourseCatalogState> {
  CatalogsModel catalog;
  CourseDetailModel courseDetail;
  @override
  CourseCatalogState clone() {
    return CourseCatalogState()
      ..catalog = catalog
      ..courseDetail = courseDetail;
  }
}
