import 'package:json_annotation/json_annotation.dart';

//  将在我们运行生成命令后自动生成
part 'course.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的 , toJson目前写死了，不需要再去生成了
// @JsonSerializable()
class CourseModel {
  String imgUrl;
  int totalVedioTime;
  String courseName;
  String author;
  String cateoryName;
  int courseId;
  String desc;

  CourseModel(
      {this.imgUrl,
      this.totalVedioTime,
      this.courseName,
      this.author,
      this.cateoryName,
      this.courseId,
      this.desc});

  //不同的类使用不同的mixin即可
  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CourseModelToJson(this);
}

@JsonSerializable()
class CourseRecordEntity {
  String imgUrl;
  String totalVedioTime;
  String courseName;
  String author;
  String cateoryName;
  String courseId;
  String desc;
  String id;
  String fileSize;

  CourseRecordEntity(
      {this.imgUrl,
      this.totalVedioTime,
      this.courseName,
      this.author,
      this.cateoryName,
      this.courseId,
      this.desc,
      this.id,
      this.fileSize});

  //不同的类使用不同的mixin即可
  factory CourseRecordEntity.fromJson(Map<String, dynamic> json) =>
      _$CourseRecordEntityFromJson(json);
  Map<String, String> toJson() => _$CourseRecordEntityToJson(this);
}
