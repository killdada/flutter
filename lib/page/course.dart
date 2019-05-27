import 'package:flutter/material.dart';

class Course extends StatefulWidget {
  @override
  State createState() => new CourseState();
}

class CourseState extends State<Course> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Text('课程'),
    );
  }
}
