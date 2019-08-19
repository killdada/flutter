import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/event/video_event.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/page/course_detail_page/vedio_page/chewie.dart';
import 'package:video_player/video_player.dart';

class VedioState implements Cloneable<VedioState> {
  CatalogsModel catalog;
  VideoPlayerController videoController;
  ChewieController chewieController;
  bool isSimple = false;
  String coverUrl;
  bool resumePlay = false;
  bool isToggleScreen = false;
  bool isFullScreen = false;
  int courseId;

  @override
  VedioState clone() {
    return VedioState()
      ..courseId = courseId
      ..videoController = videoController
      ..chewieController = chewieController
      ..isSimple = isSimple
      ..coverUrl = coverUrl
      ..resumePlay = resumePlay
      ..isToggleScreen = isToggleScreen
      ..isFullScreen = isFullScreen
      ..catalog = catalog;
  }
}

VedioState initState(Map<String, dynamic> args) {
  CatalogsModel catalog = args['catalog'];
  String coverUrl = args['coverUrl'];
  int courseId = args['courseId'];
  String url = catalog.videoUrl;
  VideoEvent videoEventData = args['videEventData'];
  print('初始化七牛播放器视频链接：$url, 是否有播放位置${videoEventData.position}');
  Map controllers = ChewiePlay.init(url, position: videoEventData.position);
  ChewieController chewieController = controllers['chewieController'];

//   if (videoEventData.position != null) {
//     Timer(Duration(milliseconds: 1000), () {
//       chewieController
//           .seekTo(Duration(seconds: videoEventData.position.inSeconds));
//     });
//   }

  return VedioState()
    ..catalog = catalog
    ..courseId = courseId
    ..coverUrl = coverUrl
    ..videoController = controllers['videoController']
    ..chewieController = chewieController;
}
