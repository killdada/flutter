import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/index.dart';
import 'package:myapp/widget/list_placeholder.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CourseDownloadState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    color: Colors.white,
    child: Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _downloadListView(state, dispatch, viewService),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.symmetric(
              horizontal: AppSize.width(46), vertical: AppSize.height(23)),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: _downloadBttomBtn("返回", 0, dispatch),
              ),
              Expanded(
                flex: 1,
                child: _downloadBttomBtn("下载全部", 1, dispatch),
              ),
              Expanded(
                flex: 1,
                child: _downloadBttomBtn("我的下载", 2, dispatch),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _downloadBttomBtn(String btnTitle, int state, Dispatch dispatch) {
  double space = state != 2 ? 46.0 : 0.0;
  Color _textColor = state == 0
      ? Color(0xFF4A4A4A)
      : state == 1 ? Color(0xFF1D9DFF) : Color(0xFFFFFFFF);
  Color _boardColor = state == 0
      ? Color(0xFFBDBDBD)
      : state == 1 ? Color(0xFF1D9DFF) : Color(0xFF1D9DFF);
  Color _bgColor = state == 2 ? Color(0xFF1D9DFF) : Colors.white;
  return InkWell(
    onTap: () {
      dispatch(CourseDownloadActionCreator.onClickItem(state));
    },
    child: Container(
      height: AppSize.height(115.0),
      // color: Colors.white,
      margin: EdgeInsets.only(right: AppSize.width(space)),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Dimens.radius_15,
        ),
        color: _bgColor,
        border: Border.all(color: _boardColor, width: AppSize.width(3)),
      ),
      child: Text(
        btnTitle,
        style: TextStyle(
          color: _textColor,
          fontSize: Dimens.sp_46,
        ),
      ),
    ),
  );
}

_downloadItemAction(int index, CatalogsModel catalog, Dispatch dispatch) {
  if (catalog.status == null ||
      catalog.status == DownloadTaskStatus.paused ||
      catalog.status == DownloadTaskStatus.failed) {
    dispatch(CourseDownloadActionCreator.onDownloadItem(index));
  }
  if (catalog.status == DownloadTaskStatus.complete) {
    print('此课程视频已经下载完成');
  } else {
    print('此课程视频已在下载队列，请勿多次下载：' + index.toString());
  }
}

Widget _downloadListView(
    CourseDownloadState state, Dispatch dispatch, ViewService viewService) {
  List<CatalogsModel> catalogs = state.courseDetail.catalogs;
  if (catalogs.isEmpty) return ListPlaceholder.empty();
  return ListView.builder(
      padding: EdgeInsets.all(0),
      scrollDirection: Axis.vertical,
      itemCount: catalogs.length,
      itemBuilder: (BuildContext context, int index) {
        bool hideLine = (index == 99 ? true : false);
        CatalogsModel _catalog = catalogs[index];
        if (_catalog != null) {
          String title = _catalog.catalogName ?? "";
          String playTime = _catalog.playTime ?? "";
          return Container(
            child: InkWell(
              onTap: () {
                if (AppUtil.isMobileNotAllowsCellularAccess()) {
                  showCelluarTips(context, true,
                      _downloadItemAction(index, _catalog, dispatch));
                  return;
                }
                _downloadItemAction(index, _catalog, dispatch);
              },
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          left: AppSize.width(55), right: AppSize.width(58)),
                      child: Text(
                        "$index",
                        style: TextStyle(
                            fontSize: AppSize.sp(43), color: Color(0xFFBDBDBD)),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            // color: Colors.grey,
                            margin: EdgeInsets.only(
                                bottom: AppSize.width(20),
                                top: AppSize.width(40)),
                            width: MediaQuery.of(context).size.width -
                                AppSize.width(190),
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontSize: AppSize.sp(43),
                                  color: Color(0xFF4A4A4A)),
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            // color: Colors.purple,
                            alignment: Alignment.topLeft,
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.only(right: AppSize.width(10)),
                                  child: Image.asset(
                                    'assets/images/icn_time.png',
                                    width: AppSize.width(35.0),
                                    height: AppSize.width(29.0),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    playTime ??= "",
                                    style: TextStyle(
                                        fontSize: AppSize.sp(35),
                                        color: Color(0xFF999999)),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: AppSize.width(35),
                                      right: AppSize.width(10)),
                                  child: Image.asset(
                                    'assets/images/icn_filesize.png',
                                    width: AppSize.width(35.0),
                                    height: AppSize.width(29.0),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    StorageUtil.convert(
                                        _catalog.videoByteSize.toDouble()),
                                    style: TextStyle(
                                        fontSize: AppSize.sp(35),
                                        color: Color(0xFF999999)),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Offstage(
                      offstage:
                          _catalog.catalogId == state.currentCatalog.catalogId
                              ? false
                              : true,
                      child: Container(
                        margin: EdgeInsets.only(right: AppSize.width(23)),
                        child: Image.asset(
                          'assets/images/icn_playing.png',
                          width: AppSize.width(35.0),
                          height: AppSize.width(29.0),
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: _catalog.status == null ? true : false,
                      child: Container(
                        margin: EdgeInsets.only(right: AppSize.width(23)),
                        child: Image.asset(
                          _catalog.status == DownloadTaskStatus.complete
                              ? 'assets/images/icn_completes.png'
                              : _catalog.status == null ||
                                      _catalog.status ==
                                          DownloadTaskStatus.failed
                                  ? ""
                                  : 'assets/images/icn_download.png',
                          width: AppSize.width(35.0),
                          height: AppSize.width(29.0),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: AppSize.width(23)),
                      child: Offstage(
                        offstage: _catalog.status == DownloadTaskStatus.failed
                            ? false
                            : true,
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/icn_attention.png',
                              width: AppSize.width(35.0),
                            ),
                            SizedBox(
                              width: AppSize.width(9.0),
                            ),
                            Text('重试',
                                style: TextStyles.style2.copyWith(
                                  color: Colours.lightRed,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ], // )
                ),
                Offstage(
                  offstage: false,
                  child: Container(
                    color: !hideLine ? Color(0xFFDDDDDD) : Color(0x0000000),
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(
                        left: AppSize.width(58),
                        right: AppSize.width(58),
                        top: AppSize.height(29)),
                    height: AppSize.height(2),
                  ),
                )
              ]),
            ),
          );
        }
      });
}
