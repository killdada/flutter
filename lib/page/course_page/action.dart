import 'package:fish_redux/fish_redux.dart';
import 'package:myapp/common/model/course/banner.dart';
import 'package:myapp/common/model/course/category.dart';


enum CourseAction { loadBanner, loadCategory, loadCourseList }

class CourseActionCreator {
  static Action fetchBanner(List<BannerModel> banners) {
    return Action(CourseAction.loadBanner, payload: banners);
  }

  static Action fetchCategory(List<CategoryModel> categories) {
    return Action(CourseAction.loadCategory, payload: categories);
  }
}
