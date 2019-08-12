import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/common/model/course-detail/course_detail_model.dart';
import 'package:myapp/common/utils/appsize.dart';
import 'package:myapp/widget/carousel_image.dart';

Widget _cacheBgImage(String uri) {
  return SizedBox(
      child: CachedNetworkImage(
    fit: BoxFit.cover,
    imageUrl: uri,
    placeholder: (context, url) => CupertinoActivityIndicator(),
    width: double.infinity,
    height: double.infinity,
  ));
}

Widget buildView(
    List<PptModel> state, Dispatch dispatch, ViewService viewService) {
  List _images = [];
  state.forEach((PptModel item) {
    String _uri = item.url;
    dynamic _image = _cacheBgImage(_uri);
    _images.add(_image);
  });
  return Text('33');
  return Carousel(
    // id: catalog.catalogId,
    curImagePage: 1,
    autoplay: false,
    showIndicator: false,
    borderRadius: true,
    radius: Radius.circular(AppSize.width(14)),
    onImageTap: (int index) {
      print('当前图片下标:$index');
      // showBigerImage(context, index, catalog);
    },
    onImageChange: (int preIndex, int currentIndex) {
      print('pre:$preIndex  current:$currentIndex');
      // _onImageChanged(catalog, currentIndex);
    },
    images: _images,
    // interval: new Duration(seconds: 1),
  );
}
