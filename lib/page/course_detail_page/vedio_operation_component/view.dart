import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/constant.dart';
import 'package:myapp/common/utils/appsize.dart';

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
          Container(
            padding: EdgeInsets.only(top: AppSize.height(20.0)),
            child: Image.asset(
              item.img,
              width: AppSize.width(36.0),
              height: AppSize.width(36.0),
              color: !_isSelected ? Color(0xFF999999) : Color(0xFF1D9DFF),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: AppSize.height(10.0)),
            child: Text(
              item.name,
              style: TextStyle(
                fontSize: AppSize.sp(22.0),
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
    color: Colors.transparent,
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
  return _toolBarWidget(state, dispatch, viewService);
}
