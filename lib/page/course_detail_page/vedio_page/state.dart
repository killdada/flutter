import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/rendering.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/widget/video_player_gather.dart';
import 'package:video_player/video_player.dart';


class VedioState implements Cloneable<VedioState> {
  CatalogsModel catalog;
  dynamic controller;
//   VideoPlayerGatherController controller = VideoPlayerGatherController();
  VideoPlayerController videoController;
  ChewieController chewieController;
  bool isSimple = false;
  String coverUrl;
  bool resumePlay = false;
  bool isToggleScreen = false;
  bool isFullScreen = false;
  PlayType playType = PlayType.video;
  VideoModel videoModel = VideoModel.complex;
  
  @override
  VedioState clone() {
    return VedioState()
      ..videoController = videoController
      ..chewieController = chewieController
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
