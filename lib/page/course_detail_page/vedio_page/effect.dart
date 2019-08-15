import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/services.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'action.dart';
import 'state.dart';

Effect<VedioState> buildEffect() {
  return combineEffects(<Object, Effect<VedioState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
  });
}


void _dispose(Action action, Context<VedioState> ctx) async {
  VedioState state = ctx.state;
  print('离开页面了啊');
  try {
    bool islogin = await DataUtils.isLogin();

    if (islogin) {
      // print('*******dispose:${_currentCatalog.catalogId}');

      // _bloc.reportLearning(widget.courseId, _currentCatalog.catalogId);
    //   int _viewingTime = state.controller.watchDuration().inSeconds;
      print('视频播放时，观看时长：');
      // if (_viewingTime > 0) {
        //   _bloc.reportLearningTime(
        //       widget.courseId, _currentCatalog.catalogId, _viewingTime);
      // }
    }
  } catch (e) {}
  state.chewieController.pause();
  state.videoController.dispose();
  state.chewieController.dispose();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
}

void _init(Action action, Context<VedioState> ctx) {
  VedioState state = ctx.state;
  if (state.catalog != null) {
    String videoUrl = state.catalog.videoUrl;
    print('初始化七牛播放器视频链接：$videoUrl');
    ctx.dispatch(VedioActionCreator.changeVideo(videoUrl));
  }
}
