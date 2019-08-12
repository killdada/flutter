import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/common/utils/appsize.dart';

Widget _catalogItem(
  CatalogsModel state,
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
                  "232",
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
              // color: !hideLine ? Color(0xFFDDDDDD) : Color(0x0000000),
              color: Color(0xFFDDDDDD),
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(
                  left: AppSize.width(58),
                  right: AppSize.width(58),
                  top: AppSize.height(29)),
              height: AppSize.height(2),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _catalogItemColum(
  CatalogsModel state,
  Dispatch dispatch,
  ViewService viewService,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        // color: Colors.grey,
        margin:
            EdgeInsets.only(bottom: AppSize.width(20), top: AppSize.width(40)),
        width: AppSize.width(200),
        // width: MediaQuery.of(context).size.width - AppSize.width(190),
        child: Text(
          state.catalogName,
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
                state.playTime ?? '',
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
    CatalogsModel state, Dispatch dispatch, ViewService viewService) {
  return _catalogItem(state, dispatch, viewService);
}
