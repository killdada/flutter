import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/utils/appsize.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SearchHeaderState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(
      horizontal: AppSize.width(36.0),
      vertical: AppSize.height(20.0),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.width(20.0),
            ),
            margin: EdgeInsets.only(right: AppSize.width(28.0)),
            height: AppSize.height(64.0),
            decoration: BoxDecoration(
              color: Color(0xFFF4F5F7),
              borderRadius: BorderRadius.all(Dimens.radius_8),
            ),
            child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/icn_search.png',
                  width: AppSize.width(26.0),
                ),
                Flexible(
                  flex: 1,
                  child: TextField(
                    controller: state.editingController,
                    focusNode: state.focusNode,
                    style: TextStyle(
                      fontSize: AppSize.sp(26.0),
                      color: Colours.textFirst,
                    ),
                    autofocus: true,
                    maxLines: 1,
                    maxLength: 15,
                    decoration: InputDecoration(
                      hintText: '课程、老师、关键词',
                      hintStyle: TextStyle(
                        fontSize: AppSize.sp(26.0),
                        color: Colours.textSecond,
                      ),
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: EdgeInsets.only(
                        left: AppSize.width(20.0),
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    onSubmitted: _doSearch,
                  ),
                ),
              ],
            ),
          ),
          flex: 1,
        ),
        InkWell(
          onTap: () {
            // if (index != 0) {
            //   setState(() {
            //     index = 0;
            //   });
            //   return;
            // }
            // Navigator.of(context).pop();
          },
          child: Text(
            '取消',
            style: TextStyles.style2.copyWith(
              fontSize: Dimens.sp_28,
            ),
          ),
        ),
      ],
    ),
  );
}

_doSearch(String text) {
  String tmpStr = text.replaceAll(" ", "");
  if (tmpStr == null || tmpStr.isEmpty) {
    showToast('请输入有效关键词');
    return;
  }
  // bloc.addHistory(text);
  // bloc.search(text);
  // setState(() {
  //   index = 1;
  // });
  // editingController.text = text;
  // focusNode.unfocus();
}

showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Color(0xFF999999),
      textColor: Colors.white,
      fontSize: AppSize.sp(40));
}
