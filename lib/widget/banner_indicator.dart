import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter/material.dart';

import 'package:myapp/common/utils/appsize.dart';

class HomeBannerPagination extends SwiperPlugin {
  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: EdgeInsets.only(bottom: AppSize.height(10.0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          config.itemCount,
          (index) {
            return Container(
              width: AppSize.width(15.0),
              height: AppSize.height(2.0),
              margin:
                  EdgeInsets.only(left: index == 0 ? 0 : AppSize.width(12.0)),
              color: index == config.activeIndex
                  ? Colors.white
                  : Colors.white.withOpacity(0.5),
            );
          },
        ),
      ),
    );
  }
}
