import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myapp/widget/banner_indicator.dart';

import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/common/constant/style.dart';

import 'dart:developer';

Widget buildView(
    BannerState state, Dispatch dispatch, ViewService viewService) {
  final List banners = state.bannerList == null ? [] : state.bannerList;

  return Padding(
    padding: EdgeInsets.fromLTRB(
      AppSize.width(52.0),
      AppSize.width(25.0),
      AppSize.width(52.0),
      AppSize.width(14.0),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Dimens.radius_12),
      child: AspectRatio(
        aspectRatio: 3.39,
        child: Swiper(
          onTap: (index) {
            //
          },
          itemCount: banners.length,
          duration: 1000,
          autoplay: true,
          autoplayDelay: 5000,
          loop: true,
          pagination: HomeBannerPagination(),
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: banners[index].imgUrl,
              placeholder: (context, url) => CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey.withOpacity(0.2),
                child: Text('图片加载失败'),
                alignment: Alignment.center,
              ),
            );
          },
        ),
      ),
    ),
  );
}
