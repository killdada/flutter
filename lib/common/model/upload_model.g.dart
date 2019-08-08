// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadModel _$UploadModelFromJson(Map<String, dynamic> json) {
  return UploadModel(
      mediaId: json['media_id'] as String,
      mediaUrl: json['media_url'] as String);
}

Map<String, dynamic> _$UploadModelToJson(UploadModel instance) =>
    <String, dynamic>{
      'media_id': instance.mediaId,
      'media_url': instance.mediaUrl
    };
