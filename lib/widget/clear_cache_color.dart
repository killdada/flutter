import 'dart:io';
import 'package:flutter/material.dart';

class ClearCacheColor extends StatelessWidget {
  final Widget child;

  ClearCacheColor({key, @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ClearCacheBehavior(),
      child: child,
    );
  }
}

class ClearCacheBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid) {
      return child;
    } else {
      return super.buildViewportChrome(context, child, axisDirection);
    }
  }
}
