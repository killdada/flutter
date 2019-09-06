import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/model/course-detail/index.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'package:myapp/page/course_detail_page/practice_tab_page/action.dart';
import 'package:myapp/page/search_page/search_header_component/effect.dart';
import 'package:myapp/router/application.dart';
import 'package:myapp/router/routers.dart';
import 'package:myapp/widget/list_placeholder.dart';

import 'state.dart';

Widget buildView(
    PracticeTabState state, Dispatch dispatch, ViewService viewService) {
  if (state.practiceData.topicId == null) {
    return ListPlaceholder.empty();
  }
  if (state.topicDetail == null) {
    return Center(
      child: CupertinoActivityIndicator(),
    );
  }
  return Column(
    children: <Widget>[
      Expanded(
        flex: 1,
        child: _listView(state, dispatch, viewService),
      )
    ],
  );
}

Widget _headerWidget(
    PracticeTabState state, Dispatch dispatch, ViewService viewService) {
  int _headerMaxLines = state.isShowDetailDesc ? 1000 : 2;
  return Container(
    width: MediaQuery.of(viewService.context).size.width,
    margin: EdgeInsets.symmetric(
        horizontal: AppSize.width(32), vertical: AppSize.width(32)),
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.fromLTRB(AppSize.width(32), AppSize.width(32),
              AppSize.width(32), AppSize.width(20)),
          child: Text(
            '主题：',
            style:
                TextStyle(fontSize: AppSize.sp(32), color: Color(0xFF4A4A4A)),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.fromLTRB(AppSize.width(32), AppSize.width(0),
              AppSize.width(32), AppSize.width(32)),
          child: Text(
            state.topicDetail?.topic?.topic ?? '',
            style:
                TextStyle(fontSize: AppSize.sp(30), color: Color(0xFF4A4A4A)),
            maxLines: _headerMaxLines,
          ),
        ),
        GestureDetector(
          onTap: () {
            dispatch(PracticeTabActionCreator.changeShowDesc());
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_headerMaxLines == 2 ? "展开详细说明 " : "收起详细说明",
                  style: TextStyle(
                      fontSize: AppSize.sp(24), color: Color(0xFFBDBDBD))),
              Icon(
                _headerMaxLines == 2
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up,
                color: Color(0xFFBDBDBD),
                size: AppSize.sp(52),
              )
            ],
          ),
        ),
        _startExerciseBtn(state, dispatch, viewService)
      ],
    ),
    decoration: BoxDecoration(
      borderRadius: new BorderRadius.circular(AppSize.width(12)),
      boxShadow: [
        BoxShadow(
            color: Color(0x55999999),
            offset: Offset(AppSize.width(0), AppSize.width(4)), //阴影位置
            blurRadius: AppSize.width(10), //阴影模糊层度
            spreadRadius: AppSize.width(10)), //阴影模糊大小
        // BoxShadow(color: Color(0x9900FF00), offset: Offset(1.0, 1.0)),
        BoxShadow(color: Colors.white)
      ],
    ),
  );
}

Widget _listViewHeader(
    PracticeTabState state, Dispatch dispatch, ViewService viewService) {
  String timeAssetName = state.sortType == 'time'
      ? "assets/images/icn_time_press.png"
      : "assets/images/icn_time_nor.png";
  String hotAssetName = state.sortType == 'hot'
      ? "assets/images/icn_hot_press.png"
      : "assets/images/icn_hot_nor.png";
  Color timeColor =
      state.sortType == 'time' ? Color(0xFF1D9DFF) : Color(0xFF999999);
  Color hotColor =
      state.sortType == 'hot' ? Color(0xFF1D9DFF) : Color(0xFF999999);
  return Container(
      margin: EdgeInsets.fromLTRB(AppSize.width(32), AppSize.width(60),
          AppSize.width(32), AppSize.width(10)),
      height: AppSize.height(45),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              '练习(${state.topicDetail.practice.length})',
              style: TextStyle(
                color: Color(0xFF4A4A4A),
                fontSize: Dimens.sp_32,
              ),
            ),
          ),
          _customButton(timeAssetName, " 时间", timeColor, () {
            if (state.sortType != 'time') {
              dispatch(PracticeTabActionCreator.onChangeSortType('time'));
            }
          }),
          _customButton(hotAssetName, " 热度", hotColor, () {
            if (state.sortType != 'hot') {
              dispatch(PracticeTabActionCreator.onChangeSortType('hot'));
            }
          }),
        ],
      ));
}

Widget _listView(
    PracticeTabState state, Dispatch dispatch, ViewService viewService) {
  return ListView.builder(
      padding: EdgeInsets.all(0),
      scrollDirection: Axis.vertical,
      itemCount: state.topicDetail.practice.length + 2 ?? 0,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _headerWidget(state, dispatch, viewService);
        }
        if (index == 1) {
          return _listViewHeader(state, dispatch, viewService);
        }
        return _listCell(index - 2, state, dispatch, viewService);
      });
}

Widget _listCell(int index, PracticeTabState state, Dispatch dispatch,
    ViewService viewService) {
  TopicPracticeModel _entity = state.topicDetail.practice[index];
  int fab = _entity.fab ?? 0;
  int commentNum = _entity.commentNum ?? 0;
  return InkWell(
    onTap: () {
      _listCellOnTap(state, dispatch, viewService, _entity);
    },
    child: Container(
      margin: EdgeInsets.fromLTRB(AppSize.width(32), AppSize.height(35),
          AppSize.width(32), AppSize.height(20)),
      // color: Colors.red,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _headPortrait(''),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSize.width(10)),
                child: Text(_entity.userShowName ?? "",
                    style: TextStyle(
                      color: Color(0xFF4A4A4A),
                      fontSize: AppSize.sp(26),
                    )),
              )
            ],
          ),
          Offstage(
            offstage: _entity.title != null ? false : true,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(
                  0, AppSize.height(20), 0, AppSize.height(14)),
              child: Text(
                _entity.title ?? "",
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontSize: AppSize.sp(32),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(
                  0, AppSize.height(10), 0, AppSize.height(20)),
              child: Text(
                _entity.content ?? "",
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontSize: AppSize.sp(28),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
          Container(
            margin: EdgeInsets.only(bottom: AppSize.height(24)),
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(_entity.modifiedAt ?? "",
                      style: TextStyle(
                        color: Color(0xFFBDBDBD),
                        fontSize: AppSize.sp(24),
                      )),
                ),
                Text('$fab赞 | $commentNum评论',
                    style: TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: AppSize.sp(24),
                    ))
              ],
            ),
          ),
          Container(
            color: Color(0xFFDDDDDD),
            height: AppSize.height(2),
          )
        ],
      ),
    ),
  );
}

Widget _headPortrait(uri) {
  return Container(
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: CachedNetworkImage(
        imageUrl: uri,
        placeholder: (context, url) => Image.asset(
          'assets/images/user_avatar.png',
          width: AppSize.width(40),
          height: AppSize.width(40),
        ),
        fit: BoxFit.fill,
        width: AppSize.width(40),
        height: AppSize.width(40),
      ),
    ),
  );
}

_listCellOnTap(PracticeTabState state, Dispatch dispatch,
    ViewService viewService, TopicPracticeModel reply) {
  int practiceId = reply.id;
  int courseId = state.practiceData.courseId;
  Application.router
      .navigateTo(
    viewService.context,
    '${Routes.practiceDetail}?courseId=$courseId&practiceId=$practiceId',
    transition: TransitionType.native,
  )
      .then((bakcValue) {
    dispatch(PracticeTabActionCreator.onFetchData());
  });
}

_startExerciseBtnOnTap(
    PracticeTabState state, Dispatch dispatch, ViewService viewService) async {
  bool isLogin = await DataUtils.isLogin();
  if (!isLogin) {
    showToast('请先登录');
    return;
  }
  int courseId = state.practiceData.courseId;
  int practiceId = state.practiceData.topicId;
  Application.router
      .navigateTo(
    viewService.context,
    '${Routes.practiceOverview}?courseId=$courseId&practiceId=$practiceId',
    transition: TransitionType.native,
  )
      .then((bakcValue) {
    dispatch(PracticeTabActionCreator.onFetchData());
  });
}

Widget _startExerciseBtn(
    PracticeTabState state, Dispatch dispatch, ViewService viewService) {
  return InkWell(
    onTap: () {
      _startExerciseBtnOnTap(state, dispatch, viewService);
    },
    child: Container(
      height: AppSize.height(80.0),
      margin: EdgeInsets.fromLTRB(AppSize.width(60), AppSize.width(40),
          AppSize.width(60), AppSize.width(20)),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Dimens.radius_15,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colours.blueLight,
            Colours.blue,
          ],
        ),
      ),
      child: Text(
        '开始练习',
        style: TextStyle(
          color: Colors.white,
          fontSize: Dimens.sp_36,
        ),
      ),
    ),
  );
}

Widget _customButton(
    String assetName, String text, Color textColor, Function onTap) {
  return Container(
    margin: EdgeInsets.only(left: AppSize.width(40), right: 0),
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Image.asset(
            assetName,
            width: AppSize.width(36),
            height: AppSize.width(36),
          ),
          Text(
            text,
            style: TextStyle(fontSize: AppSize.sp(28), color: textColor),
            maxLines: 1,
          ),
        ],
      ),
    ),
  );
}
