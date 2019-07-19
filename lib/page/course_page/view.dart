import 'dart:developer';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CourseState state, Dispatch dispatch, ViewService viewService) {
  return SafeArea(
    top: true,
    child: Column(
      children: <Widget>[
        viewService.buildComponent('search'),
        viewService.buildComponent('banner'),
        viewService.buildComponent('tabbar'),
        // Expanded(
        //   flex: 1,
        //   child: NestedScrollView(
        //     controller: state.controller,
        //     headerSliverBuilder:
        //         (BuildContext context, bool innerBoxIsScrolled) {
        //       return <Widget>[
        //         SliverToBoxAdapter(
        //           child: viewService.buildComponent('banner'),
        //         )
        //       ];
        //     },
        //     body: Text('111'),
        //   ),
        // ),
      ],
    ),
  );
}
