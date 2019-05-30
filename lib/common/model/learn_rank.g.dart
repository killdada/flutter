// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_rank.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearnRankModel _$LearnRankModelFromJson(Map<String, dynamic> json) {
  return LearnRankModel(
      list: (json['list'] as List)
          ?.map((e) => e == null
              ? null
              : LearnRankItem.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$LearnRankModelToJson(LearnRankModel instance) =>
    <String, dynamic>{'list': instance.list};
