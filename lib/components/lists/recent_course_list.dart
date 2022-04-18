import 'package:flutter/material.dart';
import 'package:flutter_first/main.dart';

import '../../model/course.dart';
import '../../screens/course_screen.dart';
import '../cards/recent_course_card.dart';

class RecentCourseList extends StatefulWidget {
  const RecentCourseList({Key? key}) : super(key: key);

  @override
  State<RecentCourseList> createState() => _RecentCourseListState();
}

class _RecentCourseListState extends State<RecentCourseList> {
  List<Container> indicators = [];
  int currenrPage = 0;

  Widget updateIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: recentCourses.map((course) {
        var index = recentCourses.indexOf(course);
        return Container(
          width: 7,
          height: 7,
          margin: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: currenrPage == index ? Color(0xFF0971FE) : Color(0xFFA6AEBD),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 320,
          width: double.infinity,
          child: PageView.builder(
            itemCount: recentCourses.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CoursesScreen(
                        course: recentCourses[index],
                      ),
                      fullscreenDialog: true,
                    ),
                  );
                },
                child: Opacity(
                    opacity: currenrPage == index ? 1 : 0.5,
                    child: RecentCourseCard(course: recentCourses[index])),
              );
            },
            controller: PageController(initialPage: 0, viewportFraction: 0.73),
            onPageChanged: (index) {
              setState(() {
                currenrPage = index;
              });
            },
          ),
        ),
        updateIndicators()
      ],
    );
  }
}
