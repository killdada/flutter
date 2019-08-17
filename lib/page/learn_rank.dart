import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myapp/common/dao/user_dao.dart';
import 'package:myapp/common/model/learn_rank_item.dart';
import 'package:myapp/common/model/userinfo.dart';
import 'package:myapp/widget/custom_image_view.dart';
import 'package:myapp/widget/custom_widget.dart';
import 'package:myapp/widget/page_wrapper.dart';
import 'package:myapp/common/dao/learn_dao.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/date_utils.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:wave/wave.dart';
import 'package:wave/config.dart';

class _Header extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget appBar;
  final Widget child;

  _Header({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.appBar,
    @required this.child,
  });

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) =>
      this != oldDelegate;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    double top = 0;
    double totalOffset = maxExtent - minExtent;
    double opacity = 0;

    if (shrinkOffset >= totalOffset) {
      top = -totalOffset;
      opacity = 1.0;
    } else {
      top = -shrinkOffset;
      opacity = shrinkOffset / totalOffset;
    }

    const startColor = const Color(0xFF259AF8);
    const endColor = const Color(0xFF43A8F7);
    final waveHeight = MediaQuery.of(context).size.width * 0.072;

    return Stack(
      overflow: Overflow.clip,
      children: <Widget>[
        Positioned(
          top: Platform.isIOS ? top : top / 2,
          left: 0,
          right: 0,
          height: maxExtent,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: const [startColor, endColor],
              ),
            ),
            child: child,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: WaveWidget(
            config: CustomConfig(
              colors: [
                Colors.white,
                Colors.white54,
                Colors.white30,
                Colors.white24,
              ],
              durations: [8000, 21000, 18000, 24000],
              heightPercentages: [0.25, 0.26, 0.28, 0.31],
              blur: MaskFilter.blur(BlurStyle.solid, 10.0),
            ),
            waveAmplitude: 0,
            size: Size.fromHeight(waveHeight),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: minExtent,
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  startColor.withOpacity(opacity),
                  endColor.withOpacity(opacity),
                ],
              ),
            ),
            child: appBar,
          ),
        ),
      ],
    );
  }
}

class LearnRank extends StatefulWidget {
  final String title;
  LearnRank({@required this.title}) : assert(title != null);

  @override
  _LearnRankState createState() => _LearnRankState();
}

class _LearnRankState extends State<LearnRank> {
  UserInfo userInfo = UserInfo();
  @override
  void initState() {
    super.initState();
    _refreshUserInfo();
  }

  void _refreshUserInfo() async {
    var userInfoLocal = await UserDao.getUserInfo();
    if (mounted) {
      if (userInfoLocal != null) {
        setState(() {
          userInfo = userInfoLocal;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int type = widget.title == '本周排行榜' ? 1 : 2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: NestedScrollView(
          headerSliverBuilder: _headerSliverBuilder,
          body: PageWrapper.pageBuilder(
            LearnDao.getLearnRankList(type),
            _content,
          ),
        ),
      ),
    );
  }

  Widget _content({List data}) {
    final items = data;
    return ListView.separated(
      padding: EdgeInsets.only(top: 0),
      itemCount: items.length,
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: AppSize.width(35.0),
            ),
            height: Dimens.divider,
            color: Color(0xFFF7F7FA),
          ),
        );
      },
      itemBuilder: (BuildContext context, int index) {
        var item = items[index];
        return _buildItem(index, item);
      },
    );
  }

  Widget _buildItem(int index, LearnRankItem item) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.width(36.0),
        vertical: AppSize.height(20.0),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: AppSize.width(55.0),
            child: Text(
              '${index + 1}',
              style: TextStyles.style2,
            ),
          ),
          CustomImageView.circle(
            path: item.userAvater ?? '',
            diameter: AppSize.width(60.0),
          ),
          SizedBox(
            width: AppSize.width(25.0),
          ),
          Text(
            item.userShowName,
            style: TextStyles.style,
          ),
          Spacer(
            flex: 1,
          ),
          Offstage(
            offstage: index != 0,
            child: Image.asset(
              'assets/images/icon_crown.png',
              width: AppSize.width(35.0),
            ),
          ),
          SizedBox(
            width: AppSize.width(14.0),
          ),
          Text(
            DateUtil.formatTime(item.value),
            style: TextStyles.style2.copyWith(fontSize: Dimens.sp_28),
          ),
        ],
      ),
    );
  }

  List<Widget> _headerSliverBuilder(
    BuildContext context,
    bool innerBoxIsScrolled,
  ) {
    final minHeight = Dimens.appBarHeight + MediaQuery.of(context).padding.top;
    return [
      SliverPersistentHeader(
        pinned: true,
        delegate: _Header(
          minHeight: Dimens.appBarHeight + MediaQuery.of(context).padding.top,
          maxHeight: MediaQuery.of(context).size.width * 0.65,
          appBar: CommonAppBar(
            leadingColor: Colors.white,
            titleColor: Colors.white,
            backgroundColor: Colors.transparent,
            title: widget.title,
            hideDivider: true,
            hideBacktext: true,
          ),
          child: _header(minHeight),
        ),
      ),
    ];
  }

  Widget _header(double height) {
    int studyTime;
    switch (widget.title) {
      case '本周排行榜':
        studyTime = userInfo.studyTimeWeek;
        break;
      case '累计排行榜':
        studyTime = userInfo.studyTimeTotal;
        break;
    }
    studyTime ??= 0;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: userInfo.userShowName == null ? 0 : 1.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: height),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: AppSize.width(130.0),
            child: CustomImageView.circle(
              path: userInfo.userAvater ?? '',
              diameter: AppSize.width(130.0),
            ),
          ),
          Text(
            userInfo.userShowName ?? '',
            style: TextStyle(
              color: Colors.white,
              fontSize: Dimens.sp_32,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.access_time,
                color: Colors.white.withOpacity(0.8),
                size: Dimens.sp_32,
              ),
              SizedBox(
                width: AppSize.width(10),
              ),
              Text(
                studyTime <= 0 ? '' : DateUtil.formatTime(studyTime),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: Dimens.sp_32,
                ),
              ),
            ],
          ),
          SizedBox(
            height:
                MediaQuery.of(context).size.width * 0.072 + AppSize.height(30),
          ),
        ],
      ),
    );
  }
}
