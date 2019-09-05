import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/dao/practice_dao.dart';
import 'package:myapp/common/model/practice_detail_model.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/index.dart';
import 'package:myapp/widget/custom_image_view.dart';
import 'package:myapp/widget/custom_widget.dart';

class PracticeDetailPage extends StatefulWidget {
  final int practiceId;
  PracticeDetailPage(this.practiceId, {Key key}) : super(key: key);

  _PracticeDetailPageState createState() => _PracticeDetailPageState();
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

class _PracticeDetailPageState extends State<PracticeDetailPage> {
  PractiveDetailModel data;

  final double _horizontalPadding = AppSize.width(46.0);

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _replyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    PractiveDetailModel res =
        await PracticeDao.getPracticeDetail(widget.practiceId);
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
          title: '练习详情',
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    if (data == null) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
    return Column(
      children: <Widget>[
        Flexible(
          child: ListView(
            controller: _scrollController,
            children: <Widget>[
              _header(data.practice),
              Column(
                children: data.replies.map((reply) => _item(reply)).toList(),
              ),
            ],
          ),
        ),
        _footer(),
      ],
    );
  }

  Widget _header(Practice practice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _horizontalPadding,
            vertical: AppSize.height(29.0),
          ),
          child: Row(
            children: <Widget>[
              _avatar(null),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      practice.nickname ?? "",
                      style: TextStyles.style.copyWith(
                        fontSize: AppSize.sp(37.0),
                      ),
                    ),
                    Text(
                      practice.createdAt ?? "",
                      style: TextStyle(
                        fontSize: AppSize.sp(35.0),
                        color: Colours.textThird,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _horizontalPadding,
          ),
          child: Text(
            practice.title ?? '无标题',
            style: TextStyles.style.copyWith(
              fontSize: AppSize.sp(46.0),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            _horizontalPadding,
            AppSize.height(12.0),
            _horizontalPadding,
            AppSize.height(58.0),
          ),
          child: Text(
            practice.content,
            style: TextStyles.style,
          ),
        ),
        Container(
          color: Color(0xFFF7F7FA),
          height: AppSize.height(23.0),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: AppSize.height(46.0),
            bottom: AppSize.height(29.0),
          ),
          child: _tip('全部评论：'),
        ),
      ],
    );
  }

  Widget _avatar(String url) {
    return Padding(
      padding: EdgeInsets.only(right: AppSize.width(32.0)),
      child: CustomImageView.circle(
        path: url,
        diameter: AppSize.width(110.0),
      ),
    );
  }

  Widget _item(Reply reply) {
    final double leftPadding = AppSize.width(46.0 + 55.0 * 2 + 32.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: _horizontalPadding,
            vertical: AppSize.height(29.0),
          ),
          child: Row(
            children: <Widget>[
              _avatar(''),
              Text(
                reply.nickname ?? "",
                style: TextStyles.style.copyWith(
                  fontSize: AppSize.sp(37.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: leftPadding,
            right: _horizontalPadding,
          ),
          child: Text(
            reply.content,
            style: TextStyles.style,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
            leftPadding,
            AppSize.height(32.0),
            _horizontalPadding,
            AppSize.height(32.0),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(
                  reply.createdAt,
                  style: TextStyle(
                    fontSize: AppSize.sp(35.0),
                    color: Colours.textThird,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  if (reply.fabed == 1) {
                    return;
                  }
                  try {
                    await PracticeDao.practiceReplyLike(reply.id);
                    initData();
                    // reply.fabed = 1;
                  } catch (error) {
                    showToast('哎呀，点赞失败啦~');
                  }
                },
                child: Image.asset(
                  reply.fabed == 1
                      ? 'assets/images/icn_like_sel.png'
                      : 'assets/images/icn_like_nor.png',
                  width: AppSize.width(52.0),
                ),
              ),
              SizedBox(
                width: AppSize.width(12.0),
              ),
              Text(
                '${reply.fab}',
                style: TextStyle(
                  fontSize: AppSize.sp(37.0),
                  color:
                      reply.fabed == 1 ? Colours.blue : const Color(0xFF999999),
                ),
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppSize.width(46.0),
          ),
          height: Dimens.divider,
          color: Color(0xFFF7F7FA),
        ),
      ],
    );
  }

  Widget _footer() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.width(46.0),
        vertical: AppSize.height(24.0),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFEEEEEE),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF4F5F7),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    AppSize.width(12.0),
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      AppSize.width(29.0),
                      AppSize.height(27.0),
                      AppSize.width(14.0),
                      AppSize.height(27.0),
                    ),
                    child: Image.asset(
                      "assets/images/icn_write.png",
                      width: AppSize.width(52.0),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _replyController,
                      maxLines: 5,
                      minLines: 1,
                      decoration: InputStyles.inputDecoration.copyWith(
                        hintText: '写下你的高能回复',
                        contentPadding: EdgeInsets.fromLTRB(
                          0,
                          AppSize.height(20.0),
                          AppSize.width(29.0),
                          AppSize.height(20.0),
                        ),
                        hintStyle: TextStyles.hintStyle.copyWith(
                          color: Colours.textSecond,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: AppSize.width(43.0),
          ),
          InkWell(
            onTap: () async {
              if (data.practice.fabed == 1) {
                return;
              }
              try {
                await PracticeDao.practiceLike(widget.practiceId);
                initData();
                // reply.fabed = 1;
              } catch (error) {
                showToast('哎呀，点赞失败啦~');
              }
            },
            child: Image.asset(
              data.practice.fabed == 1
                  ? 'assets/images/icn_like_sel.png'
                  : 'assets/images/icn_like_nor.png',
              width: AppSize.width(52.0),
            ),
          ),
          SizedBox(
            width: AppSize.width(14.0),
          ),
          Text(
            '${data.practice.fab}',
            style: TextStyle(
              color: data.practice.fabed == 1
                  ? Colours.blue
                  : const Color(0xFF999999),
              fontSize: AppSize.sp(37.0),
            ),
          ),
          SizedBox(
            width: AppSize.width(40.0),
          ),
          InkWell(
            onTap: () {
              _scrollController.animateTo(
                0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear,
              );
            },
            child: Image.asset(
              "assets/images/icn_comment.png",
              width: AppSize.width(52.0),
            ),
          ),
          SizedBox(
            width: AppSize.width(14.0),
          ),
          Text(
            '${data.replies.length}',
            style: TextStyle(
              color: Color(0xFF999999),
              fontSize: AppSize.sp(37.0),
            ),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.only(
                left: AppSize.width(40.0),
                top: AppSize.height(20.0),
                bottom: AppSize.height(20.0),
              ),
              child: Text(
                '确定',
                style: TextStyles.style.copyWith(
                  fontSize: Dimens.sp_40,
                ),
              ),
            ),
            onTap: () async {
              String content = _replyController.text;
              if (content == null || content.isEmpty) {
                showToast('请输入评论内容');
                return;
              }
              try {
                await PracticeDao.practiceReplay(widget.practiceId, content);
                initData();
                showToast('评论成功');
                _replyController.clear();
                Timer(const Duration(milliseconds: 300), () {
                  _scrollController.animateTo(
                    _scrollController.position.maxScrollExtent,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear,
                  );
                });
              } catch (error) {
                showToast('评论失败');
              }
            },
          ),
        ],
      ),
    );
  }
}
