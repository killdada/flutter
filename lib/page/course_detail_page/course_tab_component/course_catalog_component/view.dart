import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/page/course_detail_page/action.dart';
import 'package:myapp/page/course_detail_page/course_tab_component/action.dart';

Widget _catalogItem(
  Map<String, dynamic> state,
  Dispatch dispatch,
  ViewService viewService,
) {
  return Container(
    child: InkWell(
      onTap: () {
        print('点击目录：');
        // _buttonBarItemOnTap(index);
      },
      child: Column(
        children: <Widget>[
          // Container(
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    left: AppSize.width(55), right: AppSize.width(58)),
                child: Text(
                  '${state['index'] + 1}',
                  style: TextStyle(
                      fontSize: AppSize.sp(43), color: Color(0xFFBDBDBD)),
                ),
              ),
              _catalogItemColum(state, dispatch, viewService),
            ],
            // ),
            // )
          ),
          Offstage(
            offstage: false,
            child: Container(
              color: state['count'] != state['index'] + 1
                  ? Color(0xFFDDDDDD)
                  : Color(0x0000000),
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(
                  left: AppSize.width(58),
                  right: AppSize.width(58),
                  top: AppSize.height(29)),
              height: AppSize.height(2),
            ),
          ),
          Offstage(
            offstage: state['showAll'],
            child: Container(
                height: AppSize.height(86),
                margin: EdgeInsets.only(
                    top: AppSize.height(72), bottom: AppSize.height(46)),
                child: Container(
                  alignment: Alignment.center,
                  child: FlatButton(
                    child: Text(
                      '查看全部课程',
                      style: TextStyle(
                          fontSize: AppSize.sp(37), color: Color(0xFF4A4A4A)),
                    ),
                    onPressed: () {
                      dispatch(CourseDetailActionCreator.changeShowAll());
                    },
                    shape: Border.all(
                        width: AppSize.width(1), color: Color(0xFFBDBDBD)),
                  ),
                )),
          ),
          Offstage(
            offstage: state['count'] != state['index'] + 1,
            child: Container(
              color: Color(0xFFF7F7FA),
              height: AppSize.height(10.0),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _catalogItemColum(
  Map<String, dynamic> state,
  Dispatch dispatch,
  ViewService viewService,
) {
  CatalogsModel catalog = state['catalog'];
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        // color: Colors.grey,
        margin:
            EdgeInsets.only(bottom: AppSize.width(20), top: AppSize.width(40)),
        width:
            MediaQuery.of(viewService.context).size.width - AppSize.width(190),
        child: Text(
          catalog.catalogName,
          style: TextStyle(fontSize: AppSize.sp(43), color: Color(0xFF4A4A4A)),
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
              margin: EdgeInsets.only(right: AppSize.width(26)),
              child: Image.asset(
                'assets/images/icn_time.png',
                width: AppSize.width(35.0),
                height: AppSize.width(29.0),
              ),
            ),
            Container(
              child: Text(
                catalog.playTime ?? '',
                style: TextStyle(
                    fontSize: AppSize.sp(35), color: Color(0xFF999999)),
              ),
            )
          ],
        ),
      ),
    ],
  );
}

Widget buildView(
    Map<String, dynamic> state, Dispatch dispatch, ViewService viewService) {
  return _catalogItem(state, dispatch, viewService);
}
