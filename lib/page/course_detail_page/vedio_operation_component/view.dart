import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/widget/video_player_gather.dart';

import 'action.dart';
import 'state.dart';

Widget _customButton(Operations item, VedioOperationState state,
    Dispatch dispatch, ViewService viewService) {
  bool _isSelected = state.collected && item.type == ActionType.collection;
  return GestureDetector(
    onTap: () {
      dispatch(VedioOperationActionCreator.onClickItem(
        item.type,
        state.vedioOperationData,
      ));
    },
    child: Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 9, bottom: 5),
            child: Image.asset(
              item.img,
              width: 15,
              height: 15,
              color: !_isSelected ? Color(0xFF999999) : Color(0xFF1D9DFF),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 9),
            child: Text(
              item.name,
              style: TextStyle(
                fontSize: 13,
                color: !_isSelected ? Color(0xFF999999) : Color(0xFF1D9DFF),
              ),
              maxLines: 1,
            ),
          )
        ],
      ),
    ),
  );
}

Widget _toolBarWidget(
    VedioOperationState state, Dispatch dispatch, ViewService viewService) {
  final actions = [
    Operations('分享', 'assets/images/icn_share.png', ActionType.share),
    Operations('下载', 'assets/images/icn_download.png', ActionType.download),
    Operations('收藏', 'assets/images/icn_collect.png', ActionType.collection),
    Operations('反馈', 'assets/images/icn_opinion.png', ActionType.feedback),
  ];
  return Container(
    color: Colors.white,
    height: 58,
    margin: EdgeInsets.symmetric(vertical: 0),
    alignment: Alignment.center,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: actions.map((item) {
        return Expanded(
            child: _customButton(item, state, dispatch, viewService));
      }).toList(),
    ),
  );
}

Widget buildView(
    VedioOperationState state, Dispatch dispatch, ViewService viewService) {
  Size headSize = Size.fromHeight(66);
  return SliverPersistentHeader(
    pinned: true,
    delegate: SliverStickerHeader(
      height: headSize.height,
      child: PreferredSize(
        child: Container(
          child: Column(
            children: <Widget>[
              //下载、分享、反馈、收藏界面
              _toolBarWidget(state, dispatch, viewService),
              Container(
                height: 8,
                color: Color(0xFFF7F7FA),
              ),
            ],
          ),
        ),
        preferredSize: headSize,
      ),
    ),
  );
}
