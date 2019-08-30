import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/event/event_bus.dart';
import 'package:myapp/common/event/video_event.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/widget/audio_player_seekbar.dart';
import 'package:myapp/widget/custom_image_view.dart';

import 'action.dart';
import 'state.dart';

void changePlayType(AudioState state, BuildContext context) async {
  try {
    await state.audioPlayer?.pause();
    await state.audioPlayer?.dispose();
    Timer(Duration(milliseconds: 100), () {
      Navigator.of(context).pop(state.videoEventData.position);
    });
  } catch (e) {
    //
  }
}

Widget body(AudioState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    color: const Color(0xFF575F66),
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: AppSize.width(150)),
    child: Column(
      children: <Widget>[
        Spacer(
          flex: 85,
        ),
        InkWell(
          onTap: () {
            changePlayType(state, viewService.context);
          },
          child: Transform.rotate(
            child: Image.asset(
              "assets/images/icn_nav_back.png",
              color: Colors.white,
              width: AppSize.width(40),
              height: AppSize.height(40),
            ),
            angle: pi / 2 + pi,
          ),
        ),
        Spacer(
          flex: 54,
        ),
        Text(
          state.courseDetail?.categoryName ?? "-",
          style: TextStyle(
            color: Colors.white,
            fontSize: AppSize.sp(32),
          ),
        ),
        Spacer(
          flex: 6,
        ),
        Text(
          state.courseDetail?.author ?? "-",
          style: TextStyle(
            color: Colors.white,
            fontSize: AppSize.sp(26.0),
          ),
        ),
        Spacer(
          flex: 51,
        ),
        CustomImageView.square(
          path: state.courseDetail?.imgUrl,
          size: AppSize.width(330),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.width(8))),
        ),
        Spacer(
          flex: 69,
        ),
        Text(
          state.currentCatalog?.catalogName ?? "-",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: AppSize.sp(36),
          ),
        ),
        Spacer(
          flex: 117,
        ),
      ],
    ),
  );
}

Widget handle(AudioState state, Dispatch dispatch, ViewService viewService) {
  List<CatalogsModel> catalogs = state.courseDetail.catalogs;
  int catalogIndex = catalogs.indexOf(state.currentCatalog);
  return Container(
    alignment: Alignment.center,
    color: Colors.white,
    child: Row(
      children: <Widget>[
        Spacer(
          flex: 63,
        ),
        InkWell(
          onTap: () {
            dispatch(
              AudioActionCreator.onSeekTo(
                  state.videoEventData.position - Duration(seconds: 15)),
            );
          },
          child: Image.asset(
            'assets/images/icn_audio_fast_rewind.png',
            width: AppSize.width(47.0),
          ),
        ),
        Spacer(
          flex: 89,
        ),
        InkWell(
          onTap: () {
            // 已经是第一页不操作
            if (catalogIndex != 0) {
              catalogIndex++;
              if (catalogs[catalogIndex] != null) {
                AudioActionCreator.onChangePlayUrl(catalogs[catalogIndex]);
              }
            }
          },
          child: Image.asset(
            'assets/images/icn_audio_skip_previous.png',
            width: AppSize.width(36.0),
            height: AppSize.height(39.0),
          ),
        ),
        Spacer(
          flex: 80,
        ),
        InkWell(
          onTap: () {
            // if (playerController.value.isPlaying) {
            //   playerController.pause();
            // } else {
            //   playerController.play();
            // }
            // setState(() {});
          },
          //   child: Image.asset(
          //     playerController.value.isPlaying
          //         ? 'assets/images/icn_audio_pause.png'
          //         : 'assets/images/icn_audio_play.png',
          //     width: AppSize.width(173),
          //   ),
          child: Image.asset(
            'assets/images/icn_audio_play.png',
            width: AppSize.width(120),
          ),
        ),
        Spacer(
          flex: 80,
        ),
        InkWell(
          onTap: () {
            // 已经是最后一页不操作
            if (catalogIndex != catalogs.length - 1) {
              catalogIndex--;
              if (catalogs[catalogIndex] != null) {
                AudioActionCreator.onChangePlayUrl(catalogs[catalogIndex]);
              }
            }
          },
          child: Image.asset(
            'assets/images/icn_audio_skip_next.png',
            width: AppSize.width(36.0),
            height: AppSize.height(39.0),
          ),
        ),
        Spacer(
          flex: 89,
        ),
        InkWell(
          onTap: () {
            AudioActionCreator.onSeekTo(
                state.videoEventData.position + Duration(seconds: 15));
          },
          child: Image.asset(
            'assets/images/icn_audio_fast_forward.png',
            width: AppSize.width(47),
          ),
        ),
        Spacer(
          flex: 63,
        ),
      ],
    ),
  );
}

// Widget progress() {
//   return AudioPlayerSeekBar(
//     controller: playerController,
//   );
// }

Widget buildView(AudioState state, Dispatch dispatch, ViewService viewService) {
  return AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.light,
    child: WillPopScope(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: body(state, dispatch, viewService),
                        bottom: 20,
                      ),
                      //   Positioned(
                      //     child: progress(),
                      //     left: 0,
                      //     right: 0,
                      //     bottom: 0,
                      //     height: 40,
                      //   ),
                    ],
                  ),
                  flex: 900,
                ),
                Expanded(
                  child: handle(state, dispatch, viewService),
                  flex: 300,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: viewService.buildComponent('vedioOperation'),
                    color: Color(0XFFF5F5F5),
                  ),
                  flex: 130,
                ),
              ],
            )
          ],
        ),
      ),
      onWillPop: () {
        return Future.value(true);
      },
    ),
  );
}
