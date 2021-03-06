import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/model/course/course.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/date_utils.dart';
import 'package:myapp/router/application.dart';
import 'package:myapp/router/routers.dart';

import 'custom_image_view.dart';

class CourseListItem extends StatelessWidget {
  final CourseModel course;
  CourseListItem(this.course, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(
          context,
          '${Routes.courseDetail}?courseId=${course.courseId}',
          transition: TransitionType.native,
        );
      },
      child: _renderItem(this.course),
    );
  }
}

Widget _renderItem(CourseModel course) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: AppSize.width(32.0),
      vertical: AppSize.height(30.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomImageView.square(
          path: course.imgUrl,
          size: AppSize.width(158.0),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.only(left: AppSize.width(26.0)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${course.courseName}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.style.copyWith(fontSize: Dimens.sp_30),
                ),
                SizedBox(
                  height: AppSize.height(10.0),
                ),
                Text(
                  '${course.author}',
                  style: TextStyle(
                    fontSize: Dimens.sp_24,
                    color: Color(0xFF666666),
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Offstage(
                  offstage: course.totalVedioTime <= 0,
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
                        '${DateUtil.formatTime(course.totalVedioTime)}',
                        style: TextStyle(
                          fontSize: Dimens.sp_24,
                          color: Color(0xFF666666),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
