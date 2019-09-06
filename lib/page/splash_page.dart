import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/utils/data_utils.dart';
import 'package:myapp/router/application.dart';
import 'package:myapp/router/routers.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    AppSize.initDesignSize(context: context);
    afterEnter();
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset(
          'assets/images/splash.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void afterEnter() async {
    try {
      await new Future.delayed(new Duration(milliseconds: 5000));
      bool isInstalled = await DataUtils.isAppFirstInstall();
      bool isLogin = await DataUtils.isLogin();

      if (isInstalled) {
        Application.router.navigateTo(
          context,
          Routes.guide,
          replace: true,
          transition: TransitionType.native,
        );
      } else if (isLogin) {
        Application.router.navigateTo(
          context,
          Routes.home,
          replace: true,
          transition: TransitionType.native,
        );
      } else {
        Application.router.navigateTo(
          context,
          Routes.login,
          replace: true,
          transition: TransitionType.native,
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
