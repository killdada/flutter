import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:myapp/router/application.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    // AppSize.initDesignSize(context: context);

    // SPrefsManager.init().then((_) {
    //   Observable.just(1).delay(Duration(milliseconds: 500)).listen((_) {
    //     if (SPrefsManager.getBool(Constants.logined, defValue: false)) {
    //       Navigator.of(context).pushReplacementNamed('/main');
    //     } else {
    //       Navigator.of(context).pushReplacementNamed('/user/login');
    //     }
    //   });
    // });
    test();

    return Scaffold(
      body: Image.asset('assets/images/splash.png'),
    );
  }

  void test() async {
    try {
      await new Future.delayed(new Duration(milliseconds: 5000));
      Application.router.navigateTo(
        context,
        '/home',
        replace: true,
        transition: TransitionType.native,
      );
    } catch (e) {}
  }
}
