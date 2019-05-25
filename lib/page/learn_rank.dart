import 'package:flutter/material.dart';

class LearnRank extends StatefulWidget {
  final String title;
  LearnRank({@required this.title}) : assert(title != null);

  @override
  _LearnRankState createState() => _LearnRankState();
}

class _LearnRankState extends State<LearnRank> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('123'),
    );
  }
}
