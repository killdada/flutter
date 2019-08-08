import 'package:json_annotation/json_annotation.dart';

//  将在我们运行生成命令后自动生成
part 'upload_model.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class UploadModel {
  @JsonKey(name: 'media_id')
  String mediaId;
  @JsonKey(name: 'media_url')
  String mediaUrl;

  UploadModel({this.mediaId, this.mediaUrl});

  //不同的类使用不同的mixin即可
  factory UploadModel.fromJson(Map<String, dynamic> json) =>
      _$UploadModelFromJson(json);
  Map<String, dynamic> toJson() => _$UploadModelToJson(this);
}
