import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/index.dart';
import 'package:myapp/page/course_detail_page/practice_tab_component/state.dart';
import 'package:myapp/page/course_detail_page/vedio_component/state.dart';
import 'package:myapp/page/course_detail_page/vedio_operation_component/state.dart';

import 'course_tab_component/state.dart';

class CourseDetailState implements Cloneable<CourseDetailState> {
  int courseId;
  CourseDetailModel courseDetail;
  CatalogsModel currentCatalog;
  @override
  CourseDetailState clone() {
    return CourseDetailState()
      ..courseId = courseId
      ..courseDetail = courseDetail;
  }
}

CourseDetailState initState(Map<String, dynamic> args) {
  return CourseDetailState()..courseId = args['courseId'];
}

class VedioConnector
    extends Reselect1<CourseDetailState, VedioState, CatalogsModel> {
  @override
  VedioState computed(CatalogsModel sub0) {
    return VedioState()..vedioData = sub0;
  }

  @override
  CatalogsModel getSub0(CourseDetailState state) {
    return state.currentCatalog;
  }

  @override
  void set(CourseDetailState state, VedioState subState) {
    throw Exception('Unexcepted to set CourseDetailState from VedioState');
  }
}

class VedioOperationConnector
    extends Reselect1<CourseDetailState, VedioOperationState, CatalogsModel> {
  @override
  VedioOperationState computed(CatalogsModel sub0) {
    return VedioOperationState()..vedioOperationData = sub0;
  }

  @override
  CatalogsModel getSub0(CourseDetailState state) {
    return state.currentCatalog;
  }

  @override
  void set(CourseDetailState state, VedioOperationState subState) {
    throw Exception(
        'Unexcepted to set CourseDetailState from VedioOperationState');
  }
}

class CourseTabConnector
    extends Reselect1<CourseDetailState, CourseTabState, CatalogsModel> {
  @override
  CourseTabState computed(CatalogsModel sub0) {
    return CourseTabState()..courseTabData = sub0;
  }

  @override
  CatalogsModel getSub0(CourseDetailState state) {
    return state.currentCatalog;
  }

  @override
  void set(CourseDetailState state, CourseTabState subState) {
    throw Exception('Unexcepted to set CourseDetailState from CourseTabState');
  }
}

class PracticeTabConnector
    extends Reselect1<CourseDetailState, PracticeTabState, CatalogsModel> {
  @override
  PracticeTabState computed(CatalogsModel sub0) {
    return PracticeTabState()..practiceData = sub0;
  }

  @override
  CatalogsModel getSub0(CourseDetailState state) {
    return state.currentCatalog;
  }

  @override
  void set(CourseDetailState state, PracticeTabState subState) {
    throw Exception(
        'Unexcepted to set CourseDetailState from PracticeTabState');
  }
}
