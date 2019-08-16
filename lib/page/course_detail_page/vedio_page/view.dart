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

  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverOpacityHeader(
      minHeight: Dimens.appBarHeight + topPadding,
      maxHeight:
          MediaQuery.of(viewService.context).size.width * 0.62 + topPadding,
      child: Container(
        color: Colors.black,
        child: Chewie(
          controller: state.chewieController,
        ),
      ),
    ),
  );
}
