import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/dao/collection_dao.dart';
import 'package:myapp/common/model/collection_model.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/widget/custom_check_box.dart';
import 'package:myapp/widget/custom_widget.dart';
import 'package:myapp/widget/list_placeholder.dart';
import 'package:myapp/widget/custom_image_view.dart';
import 'package:myapp/common/utils/date_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:myapp/router/application.dart';
import 'package:myapp/router/routers.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CollectionPage extends StatefulWidget {
  CollectionPage({Key key}) : super(key: key);

  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  List<CollectionModel> data;
  bool canOperation = false;
  List<CollectionModel> checkedEntities = [];

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    var result = await CollectionDao.getMyCollection();
    if (mounted) {
      setState(() {
        data = result;
      });
    }
  }

  void setAllChecked() {
    if (checkedEntities.length != data.length) {
      checkedEntities.clear();
      checkedEntities.addAll(data);
      setState(() {
        checkedEntities = checkedEntities;
      });
    }
  }

  void deleteCollection() async {
    try {
      var res =
          await CollectionDao.deleCollection(checkedEntities.map((entity) {
        return entity.id;
      }).toList());
      checkedEntities.forEach((item) {
        data.remove(item);
      });
      checkedEntities.clear();
      setState(() {
        checkedEntities = checkedEntities;
      });
      Fluttertoast.showToast(msg: '删除成功');
    } catch (e) {
      Fluttertoast.showToast(msg: '删除失败');
    }
  }

  bool isChecked(CollectionModel entity) {
    return checkedEntities.contains(entity);
  }

  void setChecked(bool checked, CollectionModel entity) {
    if (checked) {
      checkedEntities.add(entity);
    } else {
      checkedEntities.remove(entity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: '我的收藏',
        trailing: Offstage(
          offstage: data == null || data.isEmpty,
          child: CommonCheckBox(
            onChanged: (checked) {
              setState(() {
                canOperation = !canOperation;
              });
            },
            checkBoxBuilder: (bool checked) {
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  0,
                  AppSize.height(20.0),
                  AppSize.width(46.0),
                  AppSize.height(20.0),
                ),
                child: Text(
                  checked ? '取消' : '管理',
                  style: TextStyles.style,
                ),
              );
            },
          ),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if (data == null) {
      return Center(
        child: CupertinoActivityIndicator(),
      );
    }
    if (data.isEmpty) {
      return ListPlaceholder.empty();
    }
    return Column(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: ListView(
            children: data.map((entity) {
              return InkWell(
                onTap: () {
                  // Application.router.navigateTo(
                  //   context,
                  //   '${Routes.courseDetail}?courseId=${entity.courseId}',
                  //   transition: TransitionType.cupertino,
                  // );
                },
                child: _buildItem(entity),
              );
            }).toList(),
          ),
        ),
        Offstage(
          offstage: !canOperation,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSize.width(46.0),
              vertical: AppSize.height(30.0),
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
                _handleBtn(
                  '全选',
                  Colours.textFirst,
                  () {
                    setAllChecked();
                  },
                ),
                SizedBox(
                  width: AppSize.width(32.0),
                ),
                _handleBtn(
                  '删除',
                  Color(0xFFF73E4D),
                  () {
                    if (checkedEntities.isEmpty) {
                      Fluttertoast.showToast(msg: '至少选择一项');
                      return;
                    }
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text('提示'),
                          content: Text('是否删除选中的课程？'),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text('取消'),
                              onPressed: () => Navigator.pop(context),
                            ),
                            CupertinoDialogAction(
                              child: Text('确定'),
                              onPressed: () {
                                deleteCollection();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(CollectionModel entity) {
    if (!canOperation) {
      return _buildItemRightContetn(entity, true);
    } else {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ImageCheckBox(
            value: isChecked(entity),
            onChanged: (checked) {
              setChecked(checked, entity);
            },
          ),
          Expanded(
            flex: 1,
            child: _buildItemRightContetn(entity, false),
          )
        ],
      );
    }
  }

  Widget _buildItemRightContetn(CollectionModel entity, bool checkboxHidden) {
    return Padding(
        padding: EdgeInsets.only(
          left: checkboxHidden ? AppSize.width(46.0) : 0,
          right: AppSize.width(46.0),
          top: AppSize.height(29.0),
          bottom: AppSize.height(29.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomImageView.square(
              path: entity.imgMediaUrl,
              size: AppSize.width(158.0),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(left: AppSize.width(37.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${entity.name}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.style.copyWith(fontSize: Dimens.sp_32),
                    ),
                    SizedBox(
                      height: AppSize.height(10.0),
                    ),
                    Text(
                      '${entity.lecturer}',
                      style: TextStyles.style2,
                    ),
                    Offstage(
                      // 暂时无时长
                      offstage: true,
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: AppSize.width(9.0)),
                            child: Image.asset(
                              'assets/images/icn_time.png',
                              width: AppSize.width(24.0),
                            ),
                          ),
                          Text(
                            '${DateUtil.formatTime(0)}',
                            style: TextStyles.style2,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Widget _handleBtn(String text, Color textColor, GestureTapCallback onTap) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: AppSize.height(80.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(
                AppSize.width(10.0),
              ),
            ),
            border: Border.all(
              color: Color(0xFFDDDDDD),
              width: Dimens.divider,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyles.style.copyWith(
                color: textColor,
                fontSize: AppSize.sp(30.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
