import 'package:flutter/material.dart';
import 'course_page/page.dart';

class Course extends StatefulWidget {
  @override
  State createState() => new CourseState();
}

class CourseState extends State<Course> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CoursePage().buildPage(null),
    );
  }
}
