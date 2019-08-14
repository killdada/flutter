import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/widget/video_player_gather.dart';

class VedioState implements Cloneable<VedioState> {
  CatalogsModel catalog;
  VideoPlayerGatherController controller = VideoPlayerGatherController();
  bool isSimple = false;
  String coverUrl;
  bool resumePlay = false;
  bool isToggleScreen = false;
  bool isFullScreen = false;
  @override
  VedioState clone() {
    return VedioState()
      ..isSimple = isSimple
      ..coverUrl = coverUrl
      ..resumePlay = resumePlay
      ..isToggleScreen = isToggleScreen
      ..isFullScreen = isFullScreen
      ..catalog = catalog
      ..controller = controller;
  }
}

VedioState initState(Map<String, dynamic> args) {
  CatalogsModel catalog = args['catalog'];
  String coverUrl = args['coverUrl'];
  return VedioState()
    ..catalog = catalog
    ..coverUrl = coverUrl;
}
