// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectionModel _$CollectionModelFromJson(Map<String, dynamic> json) {
  return CollectionModel(
      courseId: json['course_id'] as int,
      imgMediaUrl: json['img_media_url'] as String,
      createdAt: json['created_at'] as String,
      lecturer: json['lecturer'] as String,
      remark: json['remark'] as String,
      deletedAt: json['deleted_at'],
      imgMediaId: json['img_media_id'] as String,
      categoryId: json['category_id'] as int,
      name: json['name'] as String,
      id: json['id'] as int,
      modifiedAt: json['modified_at'] as String,
      catalogNum: json['catalog_num'] as int,
      username: json['username'] as String,
      status: json['status'] as int);
}

Map<String, dynamic> _$CollectionModelToJson(CollectionModel instance) =>
    <String, dynamic>{
      'course_id': instance.courseId,
      'img_media_url': instance.imgMediaUrl,
      'created_at': instance.createdAt,
      'lecturer': instance.lecturer,
      'remark': instance.remark,
      'deleted_at': instance.deletedAt,
      'img_media_id': instance.imgMediaId,
      'category_id': instance.categoryId,
      'name': instance.name,
      'id': instance.id,
      'modified_at': instance.modifiedAt,
      'catalog_num': instance.catalogNum,
      'username': instance.username,
      'status': instance.status
    };
