import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart' hide Action;
import 'package:flutter/material.dart' hide Action;
import 'package:flutter/services.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/widget/video_control.dart';
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
  VideoPlayerController videoController =
      VideoPlayerController.network(action.payload);
  ChewieController chewieController = ChewieController(
      videoPlayerController: videoController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      fullScreenByDefault: false,
      looping: false,
      allowMuting: false,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ],
      customControls: CupertinoControls(
        backgroundColor: Color.fromRGBO(41, 41, 41, 0.7),
        iconColor: Color.fromARGB(255, 200, 200, 200),
        playType: state.playType,
        videoModel: state.videoModel,
        changeModel: () {

        },
        changePlayType: () {

        },
      ),
      placeholder: new Center(
        child: CupertinoActivityIndicator(),
      ),
      routePageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondAnimation, provider) {
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget child) {
            return VideoScaffold(
              child: Scaffold(
                resizeToAvoidBottomPadding: false,
                body: Container(
                  alignment: Alignment.center,
                  color: Colors.black,
                  child: provider,
                ),
              ),
            );
          },
        );
      });
  newState.videoController = videoController;
  newState.chewieController = chewieController;
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
