import 'dart:developer';
import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/event/event_bus.dart';
import 'package:myapp/common/event/video_event.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/widget/audio_player_seekbar.dart';

import 'action.dart';
import 'state.dart';

void changePlayType(AudioState state) async {
  await state.audioPlayer.pause();
  MyEventBus.event.fire(VideoEvent(
      playType: PlayType.video,
      videoModel: state.videoEventData.videoModel,
      position: state.videoEventData.position));
}

Widget body(AudioState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    color: const Color(0xFF575F66),
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: AppSize.width(150)),
    child: Column(
      children: <Widget>[
        Spacer(
          flex: 107,
        ),
        InkWell(
          onTap: () {
            changePlayType(state);
          },
          child: Transform.rotate(
            child: Image.asset(
              "assets/images/icn_nav_back.png",
              color: Colors.white,
              width: AppSize.width(60),
              height: AppSize.height(60),
            ),
            angle: pi / 2 + pi,
          ),
        ),
        Spacer(
          flex: 78,
        ),
        // Text(
        //   widget.entity?.categoryName ?? "-",
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontSize: AppSize.sp(46),
        //   ),
        // ),
        Spacer(
          flex: 9,
        ),
        // Text(
        //   widget.entity?.author ?? "-",
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontSize: AppSize.sp(37),
        //   ),
        // ),
        // Spacer(
        //   flex: 73,
        // ),
        // CustomImageView.square(
        //   path: widget.entity?.imgUrl,
        //   size: AppSize.width(475),
        //   borderRadius: BorderRadius.all(Radius.circular(AppSize.width(12))),
        // ),
        // Spacer(
        //   flex: 98,
        // ),
        // Text(
        //   widget.entity?.catalogs[_catalogIndex]?.catalogName ?? "-",
        //   textAlign: TextAlign.center,
        //   style: TextStyle(
        //     color: Colors.white,
        //     fontSize: AppSize.sp(60),
        //   ),
        // ),
        Spacer(
          flex: 168,
        ),
      ],
    ),
  );
}

// Widget handle() {
//   return Container(
//     padding: EdgeInsets.only(bottom: AppSize.height(45)),
//     color: Colors.white,
//     child: Row(
//       children: <Widget>[
//         Spacer(
//           flex: 91,
//         ),
//         InkWell(
//           onTap: () {
//             playerController.seekTo(
//                 playerController.value.position - Duration(seconds: 15));
//           },
//           child: Image.asset(
//             'assets/images/icn_audio_fast_rewind.png',
//             width: AppSize.width(68),
//           ),
//         ),
//         Spacer(
//           flex: 128,
//         ),
//         InkWell(
//           onTap: () {
//             setState(() {
//               _catalogIndex--;
//               if (_catalogIndex < 0) {
//                 _catalogIndex = 0;
//               }
//             });
//             playerController.setDataSource(
//               widget.entity?.catalogs[_catalogIndex]?.videoUrl,
//             );
//             widget.onAction(
//               ActionEvent.previous,
//               _catalogIndex,
//             );
//           },
//           child: Image.asset(
//             'assets/images/icn_audio_skip_previous.png',
//             width: AppSize.width(56),
//           ),
//         ),
//         Spacer(
//           flex: 115,
//         ),
//         InkWell(
//           onTap: () {
//             if (playerController.value.isPlaying) {
//               playerController.pause();
//             } else {
//               playerController.play();
//             }
//             setState(() {});
//           },
//           child: Image.asset(
//             playerController.value.isPlaying
//                 ? 'assets/images/icn_audio_pause.png'
//                 : 'assets/images/icn_audio_play.png',
//             width: AppSize.width(173),
//           ),
//         ),
//         Spacer(
//           flex: 115,
//         ),
//         InkWell(
//           onTap: () {
//             var catalogs = widget.entity?.catalogs;
//             setState(() {
//               _catalogIndex++;
//               if (_catalogIndex > catalogs.length - 1) {
//                 _catalogIndex = catalogs.length - 1;
//               }
//             });
//             playerController.setDataSource(
//               widget.entity?.catalogs[_catalogIndex]?.videoUrl,
//             );
//             widget.onAction(
//               ActionEvent.next,
//               _catalogIndex,
//             );
//           },
//           child: Image.asset(
//             'assets/images/icn_audio_skip_next.png',
//             width: AppSize.width(56),
//           ),
//         ),
//         Spacer(
//           flex: 128,
//         ),
//         InkWell(
//           onTap: () {
//             playerController.seekTo(
//                 playerController.value.position + Duration(seconds: 15));
//           },
//           child: Image.asset(
//             'assets/images/icn_audio_fast_forward.png',
//             width: AppSize.width(68),
//           ),
//         ),
//         Spacer(
//           flex: 91,
//         ),
//       ],
//     ),
//   );
// }

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
                  child: Text('11'),
                  //   child: handle(),
                  flex: 300,
                ),
                Expanded(
                  child: viewService.buildComponent('vedioOperation'),
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
