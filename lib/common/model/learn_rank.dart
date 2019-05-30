import 'package:json_annotation/json_annotation.dart';
import 'learn_rank_item.dart';

//  将在我们运行生成命令后自动生成
part 'learn_rank.g.dart';

///这个标注是告诉生成器，这个类是需要生成Model类的
@JsonSerializable()
class LearnRankModel {
  List<LearnRankItem> list;

  LearnRankModel({
    this.list,
  });
  //不同的类使用不同的mixin即可
  factory LearnRankModel.fromJson(Map<String, dynamic> json) =>
      _$LearnRankModelFromJson(json);
  Map<String, dynamic> toJson() => _$LearnRankModelToJson(this);
}
