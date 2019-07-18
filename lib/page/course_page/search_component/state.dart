import 'package:fish_redux/fish_redux.dart';

class SearchState implements Cloneable<SearchState> {
  String keyword;

  SearchState({this.keyword = ''});

  @override
  SearchState clone() {
    return SearchState()..keyword = keyword;
  }

  @override
  String toString() {
    return 'ReportState{keyword: $keyword}';
  }
}

SearchState initState(Map<String, dynamic> args) {
  return SearchState();
}
