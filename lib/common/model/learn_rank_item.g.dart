// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_rank_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearnRankItem _$LearnRankItemFromJson(Map<String, dynamic> json) {
  return LearnRankItem(
      isMine: json['is_mine'] as bool,
      userAvater: json['userAvater'] as String,
      rank: json['rank'] as int,
      userShowName: json['user_show_name'] as String,
      value: json['value'] as int,
      username: json['username'] as String);
}

Map<String, dynamic> _$LearnRankItemToJson(LearnRankItem instance) =>
    <String, dynamic>{
      'is_mine': instance.isMine,
      'userAvater': instance.userAvater,
      'rank': instance.rank,
      'user_show_name': instance.userShowName,
      'value': instance.value,
      'username': instance.username
    };
