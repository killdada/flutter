// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) {
  return BannerModel(
      imgUrl: json['imgUrl'] as String,
      courseName: json['courseName'] as String,
      courseId: json['courseId'] as int);
}

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'imgUrl': instance.imgUrl,
      'courseName': instance.courseName,
      'courseId': instance.courseId
    };
