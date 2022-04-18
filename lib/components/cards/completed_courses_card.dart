import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../model/course.dart';

class CompletedCoursesCard extends StatelessWidget {
  CompletedCoursesCard({required this.course});

  final Course course;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20, right: 20),
            child: Container(
              decoration: BoxDecoration(
                gradient: course.background,
                borderRadius: BorderRadius.circular(41),
                boxShadow: [
                  BoxShadow(
                      color: course.background.colors[0].withOpacity(1),
                      offset: Offset(0, 20),
                      blurRadius: 20.0),
                  BoxShadow(
                      color: course.background.colors[1].withOpacity(0.3),
                      offset: Offset(0, 20),
                      blurRadius: 20.0),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(41),
                child: Container(
                  height: 140,
                  width: 260,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Spacer(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.courseSubtitle,
                              style: kCardSubtitleStyle,
                            ),
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Image.asset('asset/icons/icon-play.png'),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                    color: kShadowColor,
                    offset: Offset(0, 4),
                    blurRadius: 16.0),
              ],
            ),
            padding: EdgeInsets.only(
              top: 12.5,
              bottom: 13.5,
              left: 20.5,
              right: 14.5,
            ),
          ),
        ],
      ),
    );
  }
}
