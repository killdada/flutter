import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/event/video_event.dart';

import 'package:myapp/common/model/course-detail/index.dart';
import 'package:myapp/page/course_detail_page/vedio_operation_component/state.dart';

import 'course_download_component/state.dart';
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
  List<DownloadTask> tasks = [];
  StreamSubscription<ConnectivityResult> connectivitySubscription;
  ConnectivityResult connectivityStatus;

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
      ..tasks = tasks
      ..connectivitySubscription = connectivitySubscription
      ..pptIndex = pptIndex
      ..connectivityStatus = connectivityStatus;
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

// 文档不全，当使用Reselect5去链接的时候，点击下载虽然打印的state已经更改，但是视图没有更新，改用ConnOp连接以后测试正常
class CourseDownloadConnector
    extends ConnOp<CourseDetailState, CourseDownloadState> {
  @override
  CourseDownloadState get(CourseDetailState state) {
    // TODO: implement get
    CourseDownloadState data = CourseDownloadState();
    data.courseDetail = state.courseDetail;
    data.currentCatalog = state.currentCatalog;
    data.tasks = state.tasks;
    data.connectivityStatus = state.connectivityStatus;
    data.connectivitySubscription = state.connectivitySubscription;
    return data;
  }

  @override
  void set(CourseDetailState state, CourseDownloadState subState) {
    // TODO: implement set
    super.set(state, subState);
  }
}

// class CourseDownloadConnector extends Reselect5<
//     CourseDetailState,
//     CourseDownloadState,
//     CourseDetailModel,
//     CatalogsModel,
//     List<DownloadTask>,
//     StreamSubscription<ConnectivityResult>,
//     ConnectivityResult> {
//   @override
//   CourseDownloadState computed(
//       CourseDetailModel sub0,
//       CatalogsModel sub1,
//       List<DownloadTask> sub2,
//       StreamSubscription<ConnectivityResult> sub3,
//       ConnectivityResult sub4) {
//     return CourseDownloadState()
//       ..courseDetail = sub0
//       ..currentCatalog = sub1
//       ..tasks = sub2
//       ..connectivitySubscription = sub3
//       ..connectivityStatus = sub4;
//   }

//   @override
//   CourseDetailModel getSub0(CourseDetailState state) {
//     return state.courseDetail;
//   }

//   @override
//   CatalogsModel getSub1(CourseDetailState state) {
//     return state.currentCatalog;
//   }

//   @override
//   List<DownloadTask> getSub2(CourseDetailState state) {
//     return state.tasks;
//   }

//   @override
//   StreamSubscription<ConnectivityResult> getSub3(CourseDetailState state) {
//     return state.connectivitySubscription;
//   }

//   @override
//   ConnectivityResult getSub4(CourseDetailState state) {
//     return state.connectivityStatus;
//   }

//   @override
//   void set(CourseDetailState state, CourseDownloadState subState) {}
// }

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
