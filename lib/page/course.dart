import 'package:flutter/material.dart';
import 'package:myapp/store/counter.dart';
import 'package:provider/provider.dart';

class Course extends StatefulWidget {
  @override
  State createState() => new CourseState();
}

class CourseState extends State<Course> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<Counter>(context);
    final value = store.value;
    return new Center(
      child: new Text('课程'),
    );
  }
}
