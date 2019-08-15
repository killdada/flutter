import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'package:myapp/widget/video_player_gather.dart';
import 'action.dart';
import 'state.dart';

Effect<VedioState> buildEffect() {
  return combineEffects(<Object, Effect<VedioState>>{
    Lifecycle.initState: _init,
    Lifecycle.deactivate: _deactivate,
    Lifecycle.dispose: _dispose,
    Lifecycle.didUpdateWidget: _didUpdateWidget
  });
}

void _didUpdateWidget(Action action, Context<VedioState> ctx) {
//   VedioState state = ctx.state;
//   print('<<<_deactivate>>>${state.isToggleScreen}');
}

void _dispose(Action action, Context<VedioState> ctx) async {
  VedioState state = ctx.state;
  print('<<<_dispose>>>');
//   try {
//     bool islogin = await DataUtils.isLogin();

//     if (islogin) {
//       // print('*******dispose:${_currentCatalog.catalogId}');

//       // _bloc.reportLearning(widget.courseId, _currentCatalog.catalogId);
//     //   int _viewingTime = state.controller.watchDuration().inSeconds;
//       print('视频播放时，观看时长：$_viewingTime');
//       if (_viewingTime > 0) {
//         //   _bloc.reportLearningTime(
//         //       widget.courseId, _currentCatalog.catalogId, _viewingTime);
//       }
//     }
//   } catch (e) {}
//   state.controller.dispose();
  state.videoController.dispose();
  state.chewieController.dispose();
//   super.dispose();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

void playWithURL(
    Context<VedioState> ctx, String url, String coverImageUrl) async {
  VedioState state = ctx.state;
//   Timer(new Duration(microseconds: 100), () {
//   state.controller.setDataSource(url);
//   if (coverImageUrl != null) state.controller.setCoverUrl(coverImageUrl);
//   });
}

void _deactivate(Action action, Context<VedioState> ctx) {
  VedioState state = ctx.state;
  print('<<<_deactivate>>>${state.isToggleScreen}');
//   if (state.isToggleScreen) {
//     if (state.controller.isPlaying()) {
//       ctx.dispatch(VedioActionCreator.changeResumePlay(true));
//       state.controller.pause();
//     } else if (state.resumePlay) {
//       ctx.dispatch(VedioActionCreator.changeResumePlay(false));
//       state.controller.play();
//     }
//   }
}

void _init(Action action, Context<VedioState> ctx) {
  VedioState state = ctx.state;
//   VideoPlayerGatherController controller = state.controller;

  if (state.catalog != null) {
    String videoUrl = state.catalog.videoUrl;
    String coverUrl = state.coverUrl;
    print('初始化七牛播放器视频链接：$videoUrl');
    print('封面图:$coverUrl');
    ctx.dispatch(VedioActionCreator.changeVideo(videoUrl));
    // playWithURL(ctx, videoUrl, coverUrl);
  }
//   print('叶宁》》》 :${controller.isFullScreen()}');
//   controller.valueStream.listen((value) {
//     if (value.isNormal != state.isSimple) {
//       ctx.dispatch(VedioActionCreator.changeViweMode(value.isNormal));
//     }
//     if (state.isSimple) {
//       var time = value.position.inSeconds;
//       //  print('当前时间:$time');
//       //  _jumpPPTPage(time);
//     }
//     // print('full :${controller.isFullScreen()}');
//     // if (controller.isFullScreen() != state.isFullScreen) {
//     //   ctx.dispatch(
//     //       VedioActionCreator.changeFullScreen(controller.isFullScreen()));
//     //   ctx.dispatch(VedioActionCreator.changeToggleScreen(true));
//     //   Timer(Duration(milliseconds: 500), () {
//     //     print('切换屏幕操作完成，解锁状态');
//     //     ctx.dispatch(VedioActionCreator.changeToggleScreen(false));
//     //   });
//     // }
//   });
}
