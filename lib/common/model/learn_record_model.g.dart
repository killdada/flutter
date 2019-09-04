// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_record_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearnRecordModel _$LearnRecordModelFromJson(Map<String, dynamic> json) {
  return LearnRecordModel(
    courses: (json['courses'] as List)
        ?.map((e) => e == null
            ? null
            : LearnRecordCourse.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    showDate: json['show_date'] as String,
  );
}

Map<String, dynamic> _$LearnRecordModelToJson(LearnRecordModel instance) =>
    <String, dynamic>{
      'courses': instance.courses,
      'show_date': instance.showDate,
    };

LearnRecordCourse _$LearnRecordCourseFromJson(Map<String, dynamic> json) {
  return LearnRecordCourse(
    lecturer: json['lecturer'] as String,
    createdAt: json['created_at'] as String,
    remark: json['remark'] as String,
    deletedAt: json['deleted_at'],
    imgMediaId: json['img_media_id'] as String,
    categoryId: json['category_id'] as int,
    imgUrl: json['img_url'] as String,
    learningInfo: json['learning_info'] as String,
    name: json['name'] as String,
    courseCatalogId: json['course_catalog_id'] as int,
    id: json['id'] as int,
    catalogNum: json['catalog_num'] as int,
    modifiedAt: json['modified_at'] as String,
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$LearnRecordCourseToJson(LearnRecordCourse instance) =>
    <String, dynamic>{
      'lecturer': instance.lecturer,
      'created_at': instance.createdAt,
      'remark': instance.remark,
      'deleted_at': instance.deletedAt,
      'img_media_id': instance.imgMediaId,
      'category_id': instance.categoryId,
      'img_url': instance.imgUrl,
      'learning_info': instance.learningInfo,
      'name': instance.name,
      'course_catalog_id': instance.courseCatalogId,
      'id': instance.id,
      'catalog_num': instance.catalogNum,
      'modified_at': instance.modifiedAt,
      'status': instance.status,
    };
