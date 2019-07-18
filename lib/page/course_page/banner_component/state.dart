import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course/banner.dart';

class BannerState implements Cloneable<BannerState> {
  List<BannerModel> bannerList;
  @override
  BannerState clone() {
    return BannerState()..bannerList = bannerList;
  }
}

BannerState initState(Map<String, dynamic> args) {
  return BannerState();
}
