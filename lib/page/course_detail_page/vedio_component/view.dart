import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/widget/video_player_gather.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(VedioState state, Dispatch dispatch, ViewService viewService) {
  final topPadding = MediaQuery.of(viewService.context).padding.top;
  VideoPlayerGatherController _controller;
  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverOpacityHeader(
        controller: _controller,
        minHeight: Dimens.appBarHeight + topPadding,
        maxHeight:
            MediaQuery.of(viewService.context).size.width * 0.62 + topPadding,
        appBar: Text('bar'),
        child: Container(color: Colors.black)
        // child: SampleVideoPlayer(widget.controller._playerController),
        ),
  );
}
