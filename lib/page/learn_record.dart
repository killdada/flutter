import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/rendering.dart';

import 'package:myapp/widget/custom_app_bar.dart';
import 'package:myapp/common/model/learn_record_model.dart';
import 'package:myapp/widget/page_wrapper.dart';
import 'package:myapp/common/dao/learn_dao.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/date_utils.dart';
import 'package:myapp/common/constant/style.dart';

class LearnRecord extends StatefulWidget {
  @override
  _LearnRecordState createState() => _LearnRecordState();
}

class _LearnRecordState extends State<LearnRecord> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, '学习记录'),
      body: PageWrapper.pageBuilder(
        LearnDao.getLearnRecordList(),
        _content,
      ),
    );
  }

  Widget _content({List data}) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return _renderItem(index, data[index]);
      },
    );
  }

  Widget _renderItem(int index, LearnRecordModel item) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSize.width(50.0),
        right: AppSize.width(50.0),
        top: AppSize.height(70.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            item.courses.map((course) => _renderChildItem(course)).toList()
              ..insert(
                0,
                Text(
                  '${item.showDate}',
                  style: TextStyles.style.copyWith(fontSize: AppSize.sp(57.0)),
                ),
              ),
      ),
    );
  }

  Widget _renderChildItem(LearnRecordCourse course) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppSize.height(50.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Dimens.radius_15),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: course.imgUrl,
              width: AppSize.width(165.0),
              height: AppSize.width(165.0),
              placeholder: (context, url) => CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          SizedBox(
            width: AppSize.width(40.0),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${course.name}',
                style: TextStyles.style,
              ),
              SizedBox(
                height: AppSize.height(9.0),
              ),
              Text(
                '${course.lecturer}',
                style: TextStyles.style.copyWith(fontSize: Dimens.sp_36),
              ),
              SizedBox(
                height: AppSize.height(6.0),
              ),
              Text(
                  '${DateUtil.formatTime(int.parse((course.learningInfo == null || course.learningInfo.isEmpty ? '0' : course.learningInfo)))}',
                  style: TextStyle(
                    fontSize: Dimens.sp_36,
                    color: Colours.textSecond,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
