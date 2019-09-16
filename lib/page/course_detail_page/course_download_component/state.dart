import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';

class CourseDownloadState implements Cloneable<CourseDownloadState> {
  CourseDetailModel courseDetail;
  CatalogsModel currentCatalog;
  List<DownloadTask> tasks = [];
  StreamSubscription<ConnectivityResult> connectivitySubscription;
  ConnectivityResult connectivityStatus;

  @override
  CourseDownloadState clone() {
    return CourseDownloadState()
      ..courseDetail = courseDetail
      ..currentCatalog = currentCatalog
      ..tasks = tasks
      ..connectivityStatus = connectivityStatus
      ..connectivitySubscription = connectivitySubscription;
  }
}

CourseDownloadState initState(Map<String, dynamic> args) {
  return CourseDownloadState();
}
