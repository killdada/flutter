import 'package:chewie/chewie.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_video_player/flutter_video_player.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/widget/video_player_gather.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(VedioState state, Dispatch dispatch, ViewService viewService) {
  final topPadding = MediaQuery.of(viewService.context).padding.top;
//   return Container(
//     color: Colors.black,
//     child: Chewie(
//       controller: state.chewieController,
//     ),
//   );
  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverOpacityHeader(
      //   controller: state.controller,
      minHeight: Dimens.appBarHeight + topPadding,
      maxHeight:
          MediaQuery.of(viewService.context).size.width * 0.62 + topPadding,
      //   appBar: VideoAppBar(state.controller),
      child: Container(
        color: Colors.black,
        child: Chewie(
          controller: state.chewieController,
        ),
      ),
      //   child: SampleVideoPlayer(state.controller.getPlayController()),
    ),
  );
}
