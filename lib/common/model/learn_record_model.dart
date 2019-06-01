import 'package:json_annotation/json_annotation.dart';
part 'learn_record_model.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class LearnRecordModel {
  List<LearnRecordCourse> courses;
  @JsonKey(name: 'show_date')
  String showDate;

  LearnRecordModel({this.courses, this.showDate});

  //不同的类使用不同的mixin即可
  factory LearnRecordModel.fromJson(Map<String, dynamic> json) =>
      _$LearnRecordModelFromJson(json);
  Map<String, dynamic> toJson() => _$LearnRecordModelToJson(this);
}

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class LearnRecordCourse {
  String lecturer;
  @JsonKey(name: 'created_at')
  String createdAt;
  String remark;
  @JsonKey(name: 'deleted_at')
  dynamic deletedAt;
  @JsonKey(name: 'img_media_id')
  String imgMediaId;
  @JsonKey(name: 'category_id')
  int categoryId;
  @JsonKey(name: 'img_url')
  String imgUrl;
  @JsonKey(name: 'learning_info')
  String learningInfo;
  String name;
  @JsonKey(name: 'course_catalog_id')
  int courseCatalogId;
  int id;
  @JsonKey(name: 'catalog_num')
  int catalogNum;
  @JsonKey(name: 'modified_at')
  String modifiedAt;
  int status;

  LearnRecordCourse(
      {this.lecturer,
      this.createdAt,
      this.remark,
      this.deletedAt,
      this.imgMediaId,
      this.categoryId,
      this.imgUrl,
      this.learningInfo,
      this.name,
      this.courseCatalogId,
      this.id,
      this.catalogNum,
      this.modifiedAt,
      this.status});

  //不同的类使用不同的mixin即可
  factory LearnRecordCourse.fromJson(Map<String, dynamic> json) =>
      _$LearnRecordCourseFromJson(json);
  Map<String, dynamic> toJson() => _$LearnRecordCourseToJson(this);
}
