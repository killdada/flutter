import 'package:json_annotation/json_annotation.dart';

//  将在我们运行生成命令后自动生成
part 'banner.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class BannerModel {
  String imgUrl;
  String courseName;
  int courseId;

  BannerModel({this.imgUrl, this.courseName, this.courseId});

  //不同的类使用不同的mixin即可
  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);
  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}
