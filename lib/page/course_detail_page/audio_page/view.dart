import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/event/event_bus.dart';
import 'package:myapp/common/event/video_event.dart';
import 'package:myapp/common/utils/appsize.dart';

import 'action.dart';
import 'state.dart';

void changePlayType(AudioState state) async{
    await state.audioPlayer.pause();
    MyEventBus.event.fire(VideoEvent(playType:  PlayType.video, videoModel: state.videoEventData.videoModel, position: state.videoEventData.position));
}


Widget buildView(AudioState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    // backgroundColor: Color(0XFF575F66),
    backgroundColor: Colors.transparent,
    resizeToAvoidBottomInset: false,
    body: WillPopScope(
      child: SafeArea(
        top: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                changePlayType(state);
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: AppSize.height(20.0), bottom:  AppSize.height(25.0)),
                child:  Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
                size: 50.0,
              ) ,
              ),
            ),
          
          
          ],
        ),
      ),
      onWillPop: () {
        return Future.value(true);
      },
    ),
  );
}
