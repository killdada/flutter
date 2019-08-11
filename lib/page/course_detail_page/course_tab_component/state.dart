import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/page/course_detail_page/course_tab_component/course_catalog_component/state.dart';
import 'package:myapp/page/course_detail_page/course_tab_component/ppt_component/state.dart';

class CourseTabState implements Cloneable<CourseTabState> {
  CatalogsModel courseTabData;
  CourseDetailModel courseDetail;
  @override
  CourseTabState clone() {
    return CourseTabState()
      ..courseTabData = courseTabData
      ..courseDetail = courseDetail;
  }
}

class CourseCatalogConnector extends Reselect2<CourseTabState,
    CourseCatalogState, CatalogsModel, CourseDetailModel> {
  @override
  CourseCatalogState computed(CatalogsModel sub0, CourseDetailModel sub1) {
    return CourseCatalogState()
      ..catalog = sub0
      ..courseDetail = sub1;
  }

  @override
  CatalogsModel getSub0(CourseTabState state) {
    return state.courseTabData;
  }

  @override
  CourseDetailModel getSub1(CourseTabState state) {
    return state.courseDetail;
  }

  @override
  void set(CourseTabState state, CourseCatalogState subState) {
    throw Exception('Unexcepted to set CourseTabState from CourseCatalogState');
  }
}

class PptConnector extends Reselect1<CourseTabState, PptState, List<PptModel>> {
  @override
  PptState computed(List<PptModel> sub0) {
    return PptState()..pptData = sub0;
  }

  @override
  List<PptModel> getSub0(CourseTabState state) {
    return state.courseTabData.ppt;
  }

  @override
  void set(CourseTabState state, PptState subState) {
    throw Exception('Unexcepted to set CourseTabState from PptState');
  }
}
