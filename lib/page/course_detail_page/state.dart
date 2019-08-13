import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/model/course-detail/index.dart';
import 'package:myapp/page/course_detail_page/practice_tab_component/state.dart';
import 'package:myapp/page/course_detail_page/vedio_component/state.dart';
import 'package:myapp/page/course_detail_page/vedio_operation_component/state.dart';
import 'package:myapp/page/course_page/state.dart';

import 'course_tab_component/state.dart';

class CourseDetailState implements Cloneable<CourseDetailState> {
  int courseId;
  int index = 0; // 是显示下载的，还是显示目录的
  int pptIndex = 0;
  CourseDetailModel courseDetail;
  CatalogsModel currentCatalog;
  TabController tabController;
  bool showAll = false;
  bool collected = false;
  @override
  CourseDetailState clone() {
    return CourseDetailState()
      ..collected = collected
      ..currentCatalog = currentCatalog
      ..courseId = courseId
      ..courseDetail = courseDetail
      ..tabController = tabController
      ..showAll = showAll
      ..index = index
      ..pptIndex = pptIndex;
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

class VedioOperationConnector extends Reselect2<CourseDetailState,
    VedioOperationState, CourseDetailModel, bool> {
  @override
  VedioOperationState computed(CourseDetailModel sub0, bool sub1) {
    return VedioOperationState()
      ..vedioOperationData = sub0
      ..collected = sub1;
  }

  @override
  CourseDetailModel getSub0(CourseDetailState state) {
    return state.courseDetail;
  }

  @override
  bool getSub1(CourseDetailState state) {
    return state.collected;
  }

  @override
  void set(CourseDetailState state, VedioOperationState subState) {
    // throw Exception(
    //     'Unexcepted to set CourseDetailState from VedioOperationState');
  }
}

class CourseTabConnector extends Reselect4<CourseDetailState, CourseTabState,
    CatalogsModel, CourseDetailModel, bool, int> {
  @override
  CourseTabState computed(
      CatalogsModel sub0, CourseDetailModel sub1, bool sub2, int sub3) {
    return CourseTabState()
      ..courseTabData = sub0
      ..courseDetail = sub1
      ..showAll = sub2
      ..pptIndex = sub3;
  }

  @override
  CatalogsModel getSub0(CourseDetailState state) {
    return state.currentCatalog;
  }

  @override
  CourseDetailModel getSub1(CourseDetailState state) {
    return state.courseDetail;
  }

  @override
  bool getSub2(CourseDetailState state) {
    return state.showAll;
  }

  @override
  int getSub3(CourseDetailState state) {
    return state.pptIndex;
  }

  @override
  void set(CourseDetailState state, CourseTabState subState) {
    // throw Exception('Unexcepted to set CourseDetailState from CourseTabState');
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
