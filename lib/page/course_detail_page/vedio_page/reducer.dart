import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/page/course_detail_page/vedio_page/chewie.dart';
import 'package:myapp/widget/video_control.dart';
import 'package:myapp/widget/video_overlay.dart';
import 'package:myapp/widget/video_scaffold.dart';
import 'package:video_player/video_player.dart';

import 'action.dart';
import 'state.dart';

Reducer<VedioState> buildReducer() {
  return asReducer(
    <Object, Reducer<VedioState>>{
      VedioAction.changeToggleScreen: _changeToggleScreen,
      VedioAction.changeFullScreen: _changeFullScreen,
      VedioAction.changeViweMode: _changeViweMode,
      VedioAction.changeResumePlay: _changeResumePlay,
      VedioAction.changeVideo: _changeVideo
    },
  );
}

VedioState _changeVideo(VedioState state, Action action) {
  final VedioState newState = state.clone();
  Map controllers =  ChewiePlay.init(action.payload);
  newState.videoController = controllers['videoController'];
  newState.chewieController = controllers['chewieController'];
  return newState;
}

VedioState _changeResumePlay(VedioState state, Action action) {
  final VedioState newState = state.clone();
  newState.resumePlay = action.payload;
  return newState;
}

VedioState _changeViweMode(VedioState state, Action action) {
  final VedioState newState = state.clone();
  newState.isSimple = action.payload;
  return newState;
}

VedioState _changeFullScreen(VedioState state, Action action) {
  final VedioState newState = state.clone();
  newState.isFullScreen = action.payload;
  return newState;
}

VedioState _changeToggleScreen(VedioState state, Action action) {
  final VedioState newState = state.clone();
  newState.isToggleScreen = action.payload;
  return newState;
}
