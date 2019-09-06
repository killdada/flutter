import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/style.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'package:myapp/router/application.dart';
import 'package:myapp/router/routers.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() {
    return _GuidePageState();
  }
}

class _GuidePageState extends State<GuidePage> {
  int _curIndex = 0;
  @override
  Widget build(BuildContext context) {
    double safeTop = MediaQuery.of(context).padding.top;
    safeTop = safeTop > 20 ? safeTop - 20 : 0;
    return Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/guide_bg.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
            ),
            Offstage(
              offstage: _curIndex != 3 ? true : false,
              child: Image.asset(
                'assets/images/guide_bg2.png',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fill,
                alignment: Alignment.topCenter,
              ),
            ),
            Container(
              color: Colors.grey.withOpacity(0.75),
              width: double.infinity,
              height: double.infinity,
            ),
            Offstage(
                offstage: _curIndex == 0 ? false : true,
                child: Container(
                  margin: EdgeInsets.only(top: AppSize.height(570) + safeTop),
                  child: Image.asset(
                    'assets/images/img_guide1.png',
                  ),
                )),
            Offstage(
                offstage: _curIndex == 1 ? false : true,
                child: Container(
                  margin: EdgeInsets.only(top: AppSize.height(482) + safeTop),
                  child: Image.asset(
                    'assets/images/img_guide2.png',
                  ),
                )),
            Offstage(
                offstage: _curIndex == 2 ? false : true,
                child: Container(
                  margin: EdgeInsets.only(top: AppSize.height(60)),
                  child: Image.asset(
                    'assets/images/img_guide3.png',
                  ),
                )),
            Offstage(
                offstage: _curIndex == 3 ? false : true,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/images/img_guide4.png',
                  ),
                )),
            _botteomWidget()
          ],
        ));
  }

  Widget _botteomWidget() {
    return SafeArea(
        top: true,
        bottom: true,
        child: Container(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (_curIndex < 3) {
                    setState(() {
                      _curIndex += 1;
                    });
                    print('我知道了');
                  } else {
                    _quit();
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: AppSize.height(75)),
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSize.width(37),
                      vertical: AppSize.height(24)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Dimens.radius_6,
                    ),
                    color: Color(0x00000000),
                    border: Border.all(
                        color: Colors.white, width: AppSize.width(1)),
                  ),
                  child: Text(
                    '我知道了',
                    style: TextStyle(
                        fontSize: AppSize.sp(46),
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              Offstage(
                offstage: _curIndex == 3 ? true : false,
                child: Padding(
                  padding: EdgeInsets.only(bottom: AppSize.height(101)),
                  child: GestureDetector(
                    onTap: () {
                      print('*******跳过');
                      _quit();
                    },
                    child: Text('跳过',
                        style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: AppSize.sp(37),
                          color: Colors.white70,
                        )),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  _quit() async {
    bool isAppFirstInstall = await DataUtils.isAppFirstInstall();
    if (isAppFirstInstall) {
      await DataUtils.clearAppFirstInstall();
      Application.router.navigateTo(
        context,
        Routes.login,
        replace: true,
        transition: TransitionType.native,
      );
    } else {
      Navigator.pop(context);
    }
  }
}
