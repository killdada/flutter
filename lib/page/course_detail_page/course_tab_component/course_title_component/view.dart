import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/utils/appsize.dart';

Widget buildView(
    Map<String, dynamic> state, Dispatch dispatch, ViewService viewService) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.symmetric(
          vertical: AppSize.height(15.0),
          horizontal: AppSize.width(32.0),
        ),
        child: Text(
          state['title'],
          style: TextStyle(
            color: Color(0xFF4A4A4A),
            fontSize: AppSize.sp(36.0),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Offstage(
        offstage: state['desc'] == '',
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSize.height(20.0),
            horizontal: AppSize.width(32.0),
          ),
          child: Text(
            state['desc'] ?? '',
            style: TextStyle(
              color: Color(0xFF4A4A4A),
              fontSize: AppSize.sp(30.0),
            ),
          ),
        ),
      ),
    ],
  );
}
