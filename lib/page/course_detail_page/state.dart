import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/event/video_event.dart';

import 'package:myapp/common/model/course-detail/index.dart';
import 'package:myapp/page/course_detail_page/practice_tab_component/state.dart';
import 'package:myapp/page/course_detail_page/vedio_operation_component/state.dart';

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
  PlayType pageType = PlayType.video; // 传递给操作组件使用
  VideoEvent videoEventData =
      VideoEvent(playType: PlayType.video, videoModel: VideoModel.complex);

  @override
  CourseDetailState clone() {
    return CourseDetailState()
      ..videoEventData = videoEventData
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

class VedioOperationConnector extends Reselect3<CourseDetailState,
    VedioOperationState, CourseDetailModel, bool, PlayType> {
  @override
  VedioOperationState computed(
      CourseDetailModel sub0, bool sub1, PlayType sub2) {
    return VedioOperationState()
      ..vedioOperationData = sub0
      ..collected = sub1
      ..pageType = sub2;
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
  PlayType getSub2(CourseDetailState state) {
    return state.pageType;
  }

  @override
  void set(CourseDetailState state, VedioOperationState subState) {
    // throw Exception(
    //     'Unexcepted to set CourseDetailState from VedioOperationState');
  }
}

class CourseTabConnector extends Reselect5<CourseDetailState, CourseTabState,
    CatalogsModel, CourseDetailModel, bool, int, VideoEvent> {
  @override
  CourseTabState computed(CatalogsModel sub0, CourseDetailModel sub1, bool sub2,
      int sub3, VideoEvent sub4) {
    return CourseTabState()
      ..courseTabData = sub0
      ..courseDetail = sub1
      ..showAll = sub2
      ..pptIndex = sub3
      ..videoEventData = sub4;
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
  VideoEvent getSub4(CourseDetailState state) {
    return state.videoEventData;
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
