import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/model/course-detail/index.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/page/course_detail_page/practice_tab_component/action.dart';
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
        horizontal: AppSize.width(46), vertical: AppSize.width(46)),
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.fromLTRB(AppSize.width(46), AppSize.width(46),
              AppSize.width(46), AppSize.width(29)),
          child: Text(
            '主题：',
            style:
                TextStyle(fontSize: AppSize.sp(46), color: Color(0xFF4A4A4A)),
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.fromLTRB(AppSize.width(46), AppSize.width(0),
              AppSize.width(46), AppSize.width(46)),
          child: Text(
            state.topicDetail.topic ?? "",
            style:
                TextStyle(fontSize: AppSize.sp(46), color: Color(0xFF4A4A4A)),
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
                      fontSize: AppSize.sp(35), color: Color(0xFFBDBDBD))),
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
        _startExerciseBtn()
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
      margin: EdgeInsets.fromLTRB(AppSize.width(46), AppSize.width(86),
          AppSize.width(46), AppSize.width(10)),
      height: AppSize.height(65),
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
                fontSize: Dimens.sp_46,
              ),
            ),
          ),
          _customButton(timeAssetName, " 时间", timeColor, () {
            if (state.sortType != 'time') {
              dispatch(PracticeTabActionCreator.changeSortType('time'));
            }
          }),
          _customButton(hotAssetName, " 热度", hotColor, () {
            if (state.sortType != 'hot') {
              dispatch(PracticeTabActionCreator.changeSortType('hot'));
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
  int comment_num = _entity.commentNum ?? 0;
  return InkWell(
    onTap: () {
      _listCellOnTap();
    },
    child: Container(
      margin: EdgeInsets.fromLTRB(AppSize.width(46), AppSize.height(49),
          AppSize.width(46), AppSize.height(35)),
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
                padding: EdgeInsets.symmetric(horizontal: AppSize.width(14)),
                child: Text(_entity.userShowName ?? "",
                    style: TextStyle(
                      color: Color(0xFF4A4A4A),
                      fontSize: AppSize.sp(37),
                    )),
              )
            ],
          ),
          Offstage(
            offstage: _entity.title != null ? false : true,
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(
                  0, AppSize.height(30), 0, AppSize.height(14)),
              child: Text(
                _entity.title ?? "",
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontSize: AppSize.sp(46),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(
                  0, AppSize.height(30), 0, AppSize.height(29)),
              child: Text(
                _entity.content ?? "",
                style: TextStyle(
                  color: Color(0xFF4A4A4A),
                  fontSize: AppSize.sp(46),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )),
          Container(
            margin: EdgeInsets.only(bottom: AppSize.height(35)),
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Text(_entity.modifiedAt ?? "",
                      style: TextStyle(
                        color: Color(0xFFBDBDBD),
                        fontSize: AppSize.sp(35),
                      )),
                ),
                Text('$fab赞 | $comment_num评论',
                    style: TextStyle(
                      color: Color(0xFFBDBDBD),
                      fontSize: AppSize.sp(35),
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
      borderRadius: BorderRadius.circular(29.0),
      child: CachedNetworkImage(
        imageUrl: uri,
        placeholder: (context, url) => Image.asset(
          'assets/images/user_avatar.png',
          width: AppSize.width(65),
          height: AppSize.width(65),
        ),
        fit: BoxFit.fill,
        width: AppSize.width(65),
        height: AppSize.width(65),
      ),
    ),
  );
}

_listCellOnTap() {
//   int practiceId = rep.id;
// //    widget.videoController.pause();
//   Router.appRouter
//       .navigateTo(
//     context,
//     '${Routes.practiceDetail}?practiceId=$practiceId',
//     transition: TransitionType.cupertino,
//   )
//       .then((bakcValue) {
//     _bloc.getTopicDetail(widget.topicId, _sortType);
//   });
}

__startExerciseBtnOnTap() {
//    widget.videoController.pause();
//   int courseId = widget.couseId;
//   int practiceId = widget.topicId;
//   Router.appRouter
//       .navigateTo(
//     context,
//     '${Routes.practiceOverview}?courseId=$courseId&practiceId=$practiceId',
//     transition: TransitionType.cupertino,
//   )
//       .then((bakcValue) {
//     _bloc.getTopicDetail(widget.topicId, _sortType);
//   });
}

Widget _startExerciseBtn() {
  return InkWell(
    onTap: __startExerciseBtnOnTap,
    child: Container(
      height: AppSize.height(115.0),
      margin: EdgeInsets.fromLTRB(AppSize.width(86), AppSize.width(58),
          AppSize.width(86), AppSize.width(40)),
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
          fontSize: Dimens.sp_48,
        ),
      ),
    ),
  );
}

Widget _customButton(
    String assetName, String text, Color textColor, Function onTap) {
  return Container(
    margin: EdgeInsets.only(left: AppSize.width(58), right: 0),
    child: GestureDetector(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Image.asset(
            assetName,
            width: AppSize.width(52),
            height: AppSize.width(52),
          ),
          Text(
            text,
            style: TextStyle(fontSize: AppSize.sp(40), color: textColor),
            maxLines: 1,
          ),
        ],
      ),
    ),
  );
}
