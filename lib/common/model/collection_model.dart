import 'package:json_annotation/json_annotation.dart';
//  将在我们运行生成命令后自动生成
part 'collection_model.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class CollectionModel {
  @JsonKey(name: 'course_id')
  int courseId;
  @JsonKey(name: 'img_media_url')
  String imgMediaUrl;
  @JsonKey(name: 'created_at')
  String createdAt;
  String lecturer;
  String remark;
  @JsonKey(name: 'deleted_at')
  dynamic deletedAt;
  @JsonKey(name: 'img_media_id')
  String imgMediaId;
  @JsonKey(name: 'category_id')
  int categoryId;
  String name;
  int id;
  @JsonKey(name: 'modified_at')
  String modifiedAt;
  @JsonKey(name: 'catalog_num')
  int catalogNum;
  String username;
  int status;

  CollectionModel({
    this.courseId,
    this.imgMediaUrl,
    this.createdAt,
    this.lecturer,
    this.remark,
    this.deletedAt,
    this.imgMediaId,
    this.categoryId,
    this.name,
    this.id,
    this.modifiedAt,
    this.catalogNum,
    this.username,
    this.status,
  });
  //不同的类使用不同的mixin即可
  factory CollectionModel.fromJson(Map<String, dynamic> json) =>
      _$CollectionModelFromJson(json);
  Map<String, dynamic> toJson() => _$CollectionModelToJson(this);
}
