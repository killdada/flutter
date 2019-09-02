import 'package:json_annotation/json_annotation.dart';
part 'course_detail_model.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class CourseDetailModel {
  int courseId;
  String courseName;
  String imgUrl;
  String categoryName;
  List<CatalogsModel> catalogs;
  int topicId;
  int collected;
  String author;

  CourseDetailModel({
    this.courseId,
    this.courseName,
    this.imgUrl,
    this.categoryName,
    this.catalogs,
    this.topicId,
    this.collected,
    this.author,
  });

  //不同的类使用不同的mixin即可
  factory CourseDetailModel.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$CourseDetailModelToJson(this);
}

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class CatalogsModel {
  int catalogId;
  String catalogName;
  String catalogAlias;
  String videoUrl;
  String catalogDesc;
  String playTime;
  List<PptModel> ppt;
  int curPptIndex;
  int totalPptCount;
  String pptTitle;

  CatalogsModel({
    this.catalogId,
    this.catalogName,
    this.catalogAlias,
    this.videoUrl,
    this.catalogDesc,
    this.playTime,
    this.ppt,
    this.curPptIndex,
    this.pptTitle,
    this.totalPptCount,
  });

  //不同的类使用不同的mixin即可
  factory CatalogsModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogsModelFromJson(json);
  Map<String, dynamic> toJson() => _$CatalogsModelToJson(this);
}

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class PptModel {
  String url;
  @JsonKey(name: 'start_time')
  int timeStart;
  @JsonKey(name: 'end_time')
  int timeEnd;

  PptModel({this.url, this.timeStart, this.timeEnd});

  //不同的类使用不同的mixin即可
  factory PptModel.fromJson(Map<String, dynamic> json) =>
      _$PptModelFromJson(json);
  Map<String, dynamic> toJson() => _$PptModelToJson(this);
}
