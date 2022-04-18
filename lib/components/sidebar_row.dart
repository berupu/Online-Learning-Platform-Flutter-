import 'package:flutter/material.dart';
import 'package:flutter_first/constants.dart';
import 'package:flutter_first/screens/course_sections_screen.dart';
import 'package:flutter_first/screens/exam_screen.dart';
import 'package:flutter_first/screens/home_screen.dart';
import '../model/sidebar.dart';

class SidebarRow extends StatelessWidget {
  SidebarRow({required this.item});

  final SidebarItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.title == "Home") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => HomeScreen()));
        } else if (item.title == "Courses") {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CourseSectionsScreen()));
        } else if (item.title == "Exams") {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ExamScreen()));
        } else {
          print("go to setting");
        }
      },
      child: Row(
        children: [
          Container(
              width: 42.0,
              height: 42.0,
              padding: EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.0),
                  gradient: item.background),
              child: item.icon),
          SizedBox(width: 12),
          Container(
            child: Text(
              item.title,
              style: kCalloutLabelStyle,
            ),
          ),
        ],
      ),
    );
  }
}
