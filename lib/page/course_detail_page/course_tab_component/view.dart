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
        dispatch(CourseTabActionCreator.onChangeCurrentTab(catalog));
      },
      child: Container(
        margin: EdgeInsets.only(
          left: AppSize.width(32),
          right: AppSize.width(20),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSize.width(4)),
            color: Color(0xFFF3F3F3)),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppSize.width(28), vertical: AppSize.height(1.0)),
          child: Text(
            catalog.catalogAlias,
            style: TextStyle(
              fontSize: AppSize.sp(24),
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
        margin: EdgeInsets.only(top: AppSize.height(40)),
        height: AppSize.height(70),
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
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: adapter.itemBuilder,
          itemCount: adapter.itemCount,
        ),
      ),
    ],
  );
}
