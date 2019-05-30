import 'package:json_annotation/json_annotation.dart';
//  将在我们运行生成命令后自动生成
part 'learn_rank_item.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class LearnRankItem {
  @JsonKey(name: 'is_mine')
  bool isMine;
  String userAvater;
  int rank;
  @JsonKey(name: 'user_show_name')
  String userShowName;
  int value;
  String username;

  LearnRankItem(
      {this.isMine,
      this.userAvater,
      this.rank,
      this.userShowName,
      this.value,
      this.username});
  //不同的类使用不同的mixin即可
  factory LearnRankItem.fromJson(Map<String, dynamic> json) =>
      _$LearnRankItemFromJson(json);
  Map<String, dynamic> toJson() => _$LearnRankItemToJson(this);
}
