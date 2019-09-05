import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/dao/practice_dao.dart';
import 'package:myapp/common/model/practice_overview_model.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/index.dart';
import 'package:myapp/widget/clear_cache_color.dart';
import 'package:myapp/widget/clear_text_field.dart';
import 'package:myapp/widget/custom_check_box.dart';
import 'package:myapp/widget/custom_widget.dart';
import 'package:myapp/widget/loading_dialog.dart';

class PractiveOverviewPage extends StatefulWidget {
  final int practiceId;
  final int courseId;

  PractiveOverviewPage(this.courseId, this.practiceId, {Key key})
      : super(key: key);

  _PractiveOverviewPageState createState() => _PractiveOverviewPageState();
}

class _PractiveOverviewPageState extends State<PractiveOverviewPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  PracticeOverviewModel data;

  int detailMaxLines = 2;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    PracticeOverviewModel res = await PracticeDao.practice(
      widget.courseId,
      widget.practiceId,
    );
    setState(() {
      data = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutoHideKeyboardWidget(context, _scaffoldWidget());
  }

  Widget _scaffoldWidget() {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: CommonScaffold(
        appBar: CommonAppBar(
          title: '练习概览',
          trailing: Container(
            margin: EdgeInsets.all(AppSize.width(20.0)),
            width: AppSize.width(160),
            height: AppSize.height(75),
            decoration: BoxDecoration(
              color: Colours.blue,
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.width(40)),
              ),
            ),
            child: InkWell(
              onTap: () async {
                String title = _titleController.text;
                String content = _contentController.text;
                if (title.isEmpty) {
                  showToast('请输入标题');
                  return;
                }
                if (content.isEmpty) {
                  showToast('请输入练习内容');
                  return;
                }
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return LoadingDialog(
                        text: '正在发布',
                      );
                    });
                try {
                  await PracticeDao.practiceSubmit(
                    widget.courseId,
                    widget.practiceId,
                    title,
                    content,
                  );
                  hideKeyboard(context);
                  Navigator.pop(context);
                  showToast('发布成功');
                  Timer(const Duration(milliseconds: 1000), () {
                    Navigator.pop(context);
                  });
                } catch (e) {
                  showToast('发布失败');
                  hideKeyboard(context);
                  Navigator.pop(context);
                }
              },
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    '发布',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Dimens.sp_42,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: _bodyContainer(),
      ),
    );
  }

  Widget _bodyContainer() {
    if (data == null) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
    return LayoutBuilder(
      builder: (_, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: _body(),
            ),
          ),
        );
      },
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
            top: AppSize.height(75.0),
            right: AppSize.width(46.0),
          ),
          child: _tip('主题：'),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppSize.width(46.0),
          ),
          padding: EdgeInsets.only(
            top: AppSize.height(27.0),
          ),
          child: Text(
            data.topic,
            style: TextStyles.style,
            maxLines: detailMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        _expandDetail(),
        _tip('我的练习：'),
        _title(),
        Expanded(
          flex: 1,
          child: _content(),
        ),
      ],
    );
  }

  Widget _expandDetail() {
    return CommonCheckBox(
      onChanged: (checked) =>
          setState(() => detailMaxLines = checked ? 1000 : 2),
      checkBoxBuilder: (bool checked) {
        Widget child;
        if (checked) {
          child = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '收起详细说明',
                style: TextStyles.style2.copyWith(
                  color: Colours.textSecond,
                ),
              ),
              Icon(
                Icons.expand_less,
                size: Dimens.sp_46,
                color: Colours.textSecond,
              ),
            ],
          );
        } else {
          child = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '展开详细说明',
                style: TextStyles.style2.copyWith(
                  color: Colours.textSecond,
                ),
              ),
              Icon(
                Icons.expand_more,
                size: Dimens.sp_46,
                color: Colours.textSecond,
              ),
            ],
          );
        }
        return Padding(
          padding: EdgeInsets.all(AppSize.height(46.0)),
          child: child,
        );
      },
    );
  }

  Widget _title() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        AppSize.width(46.0),
        AppSize.height(39.0),
        AppSize.width(46.0),
        0,
      ),
      height: AppSize.height(127.0),
      decoration: BoxDecoration(
        color: Color(0xFFF4F5F7),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.width(12.0),
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          right: AppSize.width(46.0),
        ),
        child: ClearTextField(
          controller: _titleController,
          maxLength: 20,
          maxLines: 1,
          style: TextStyles.style,
          decoration: InputStyles.inputDecoration.copyWith(
            hintText: '起个响亮的标题，限���20字内',
            contentPadding: EdgeInsets.only(
              left: AppSize.width(46.0),
              right: AppSize.width(10.0),
            ),
            hintStyle: TextStyles.hintStyle.copyWith(
              color: Colours.textSecond,
            ),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return Container(
      margin: EdgeInsets.fromLTRB(
        AppSize.width(46.0),
        AppSize.height(29.0),
        AppSize.width(46.0),
        AppSize.width(58.0),
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF4F5F7),
        borderRadius: BorderRadius.all(
          Radius.circular(
            AppSize.width(12.0),
          ),
        ),
      ),
      child: Stack(
        children: <Widget>[
          ClearCacheColor(
            child: TextField(
              controller: _contentController,
              maxLength: 1000,
              maxLines: 10,
              style: TextStyles.style,
              decoration: InputStyles.inputDecoration.copyWith(
                hintText: '写下你的练习内容',
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppSize.width(46.0),
                  vertical: AppSize.width(43.0),
                ),
                hintStyle: TextStyles.hintStyle.copyWith(
                  color: Colours.textSecond,
                ),
              ),
            ),
          ),
          Positioned(
            right: AppSize.width(43.0),
            bottom: AppSize.width(43.0),
            child: Text(
              '${_contentController.text.length}/1000',
              style: TextStyle(
                color: Color(0xFF999999),
                fontSize: Dimens.sp_36,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tip(String title) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(
            right: AppSize.width(32.0),
          ),
          width: AppSize.width(14.0),
          height: AppSize.height(46.0),
          decoration: BoxDecoration(
            color: Colours.blue,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(2.0),
            ),
          ),
        ),
        Text(
          title,
          style: TextStyles.style.copyWith(
            fontSize: Dimens.sp_46,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
