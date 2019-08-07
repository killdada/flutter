import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/constant/style.dart';

class CustomImageView extends StatelessWidget {
  final String path;
  final double width;
  final double height;
  final BoxFit fit;
  final BoxShape shape;
  final BorderRadius borderRadius;
  final Widget placeholder;
  final Widget errorWidget;

  CustomImageView({
    key,
    this.path,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.shape = BoxShape.circle,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  CustomImageView.circle({
    String path,
    double diameter,
    BoxFit fit,
    Widget placeholder,
    Widget errorWidget,
  }) : this(
          path: path ?? '',
          width: diameter,
          height: diameter,
          fit: fit ?? BoxFit.cover,
          shape: BoxShape.circle,
          placeholder: Image.asset('assets/images/user_avatar.png'),
          errorWidget: Image.asset('assets/images/user_avatar.png'),
        );

  CustomImageView.rect({
    String path,
    double width,
    double height,
    BoxFit fit,
    BorderRadius borderRadius,
  }) : this(
          path: path ?? '',
          width: width,
          height: height,
          fit: fit ?? BoxFit.cover,
          shape: BoxShape.rectangle,
          borderRadius: borderRadius ?? BorderRadius.all(Dimens.radius_12),
          placeholder: CupertinoActivityIndicator(),
          errorWidget: Container(
            color: Colors.grey.withOpacity(0.2),
            alignment: Alignment.center,
            child: Text('error'),
          ),
        );

  CustomImageView.square({
    String path,
    double size,
    BoxFit fit,
    BorderRadius borderRadius,
  }) : this.rect(
          path: path,
          width: size,
          height: size,
          fit: fit,
          borderRadius: borderRadius,
        );

  @override
  Widget build(BuildContext context) {
    if (path == '') {
      print(width);
      return Image.asset(
        'assets/images/user_avatar.png',
        width: width,
        height: height,
      );
    }
    Widget content = SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        fit: fit ?? BoxFit.cover,
        imageUrl: path ?? '',
        placeholder: (context, url) => placeholder,
        errorWidget: (context, url, error) => errorWidget,
      ),
    );

    if (shape == BoxShape.circle) {
      return ClipOval(
        child: content,
      );
    } else {
      return ClipRRect(
        child: content,
        borderRadius: borderRadius,
      );
    }
  }
}
