import 'package:flutter/material.dart';
import 'package:flutter_first/constants.dart';
import '../../model/course.dart';

class CourseSectionCard extends StatelessWidget {
  CourseSectionCard({required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(41),
            gradient: course.background,
            boxShadow: [
              BoxShadow(
                color: course.background.colors[0].withOpacity(0.3),
                blurRadius: 30,
                offset: Offset(0, 20),
              ),
              BoxShadow(
                color: course.background.colors[1].withOpacity(0.3),
                blurRadius: 30,
                offset: Offset(0, 20),
              ),
            ]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(41),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(course.courseSubtitle,
                              style: kCardSubtitleStyle),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            course.courseTitle,
                            style: kCardTitleStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
