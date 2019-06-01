import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myapp/widget/custom_app_bar.dart';
import 'package:myapp/common/model/learn_rank_item.dart';
import 'package:myapp/widget/page_wrapper.dart';
import 'package:myapp/common/dao/learn_dao.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/date_utils.dart';
import 'package:myapp/common/constant/style.dart';
import 'dart:developer';

class LearnRank extends StatefulWidget {
  final String title;
  LearnRank({@required this.title}) : assert(title != null);

  @override
  _LearnRankState createState() => _LearnRankState();
}

class _LearnRankState extends State<LearnRank> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int type = widget.title == '本周排行榜' ? 1 : 2;

    return Scaffold(
      appBar: CustomAppBar(context, '${widget.title}'),
      body: PageWrapper.pageBuilder(
        LearnDao.getLearnRankList(type),
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

  Widget _renderItem(int index, LearnRankItem item) {
    return Padding(
      padding: EdgeInsets.all(AppSize.width(20.0)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Dimens.radius_15),
          gradient: index == 0
              ? LinearGradient(colors: [Colours.blueLight, Colours.blue])
              : index == 1
                  ? LinearGradient(colors: [
                      Colours.blueLight.withAlpha(0xEE),
                      Colours.blue.withAlpha(0xEE)
                    ])
                  : LinearGradient(colors: [Colors.white, Colors.white]),
          boxShadow: index < 2
              ? [
                  BoxShadow(
                    offset: Offset(0.0, 0.0),
                    color: Colours.blueLight.withAlpha(0x55),
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                  ),
                ]
              : [
                  BoxShadow(
                    offset: Offset(0.0, 0.0),
                    color: Colors.grey.withAlpha(0x30),
                    blurRadius: 5.0,
                    spreadRadius: 5.0,
                  ),
                ],
        ),
        margin: EdgeInsets.only(top: index == 0 ? AppSize.height(12.0) : 0),
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.width(45.0),
          vertical: AppSize.height(61.0),
        ),
        child: Row(
          children: <Widget>[
            Text(
              'No.${index + 1}',
              style: TextStyles.style.copyWith(
                  color: index < 2 ? Colors.white : Colours.textFirst),
            ),
            SizedBox(
              width: AppSize.width(42.0),
            ),
            CircleAvatar(
              radius: AppSize.width(46.0),
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: item.userAvater ?? '',
                placeholder: (context, url) =>
                    Image.asset('assets/images/user_avatar.png'),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/user_avatar.png'),
              ),
            ),
            SizedBox(
              width: AppSize.width(27.0),
            ),
            Expanded(
              flex: 1,
              child: Text(
                item.userShowName,
                style: TextStyles.style.copyWith(
                    fontSize: Dimens.sp_45,
                    color: index < 2 ? Colors.white : Colours.textFirst),
              ),
            ),
            SizedBox(
              width: AppSize.width(42.0),
            ),
            Text(
              DateUtil.formatTime(item.value),
              style: TextStyles.style.copyWith(
                  color: index < 2 ? Colors.white : Colours.textSecond),
            ),
          ],
        ),
      ),
    );
  }
}
