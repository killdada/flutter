import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/common/utils/appsize.dart';

import 'action.dart';
import 'state.dart';

Widget _buttonBarItem(
  CourseTabState state,
  Dispatch dispatch,
  ViewService viewService,
  CatalogsModel catalog,
  bool isActive,
) {
  return GestureDetector(
      onTap: () {
        // _buttonBarItemOnTap(index);
        dispatch(CourseTabActionCreator.onChangeCurrentTab(catalog));
      },
      child: Container(
        margin: EdgeInsets.only(
          left: AppSize.width(46),
          right: AppSize.width(40),
          top: AppSize.height(25),
          bottom: AppSize.height(25),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.width(6)),
            color: Color(0xFFF3F3F3)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.width(32), vertical: AppSize.height(27)),
          child: Text(
            catalog.catalogAlias,
            style: TextStyle(
              fontSize: AppSize.sp(35),
              color: isActive ? Color(0xFF1D9DFF) : Color(0xFF666666),
            ),
          ),
        ),
      ));
}

Widget buildView(
    CourseTabState state, Dispatch dispatch, ViewService viewService) {
  CatalogsModel courseTabData = state.courseTabData;
  List<CatalogsModel> catalogs = state.courseDetail.catalogs;
  final ListAdapter adapter = viewService.buildAdapter();
  return Column(
    children: <Widget>[
      Container(
        // color: Colors.red,
        margin: EdgeInsets.symmetric(vertical: AppSize.height(48)),
        height: AppSize.height(160),
        alignment: Alignment.center,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: catalogs.length,
          itemBuilder: (BuildContext context, int index) {
            return _buttonBarItem(state, dispatch, viewService, catalogs[index],
                courseTabData == catalogs[index]);
          },
        ),
      ),
      Expanded(
        flex: 1,
        child: ListView.builder(
          itemBuilder: adapter.itemBuilder,
          itemCount: adapter.itemCount,
        ),
      ),
    ],
  );
}
