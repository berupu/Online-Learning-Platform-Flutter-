import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/constants.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../model/course.dart';
import 'course_sections_screen.dart';

class CoursesScreen extends StatefulWidget {
  CoursesScreen({required this.course});

  final Course course;

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  //get kBackgroundColor => null;
  Widget indicators() {
    List<Widget> indicators = [];

    for (var i = 0; i < 9; i++) {
      indicators.add(Container(
        width: 7,
        height: 7,
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: i == 0 ? Color(0xFF0971FE) : Color(0xFFA6AEBD)),
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators,
    );
  }

  late PanelController panelController;

  @override
  void initState() {
    super.initState();
    panelController = PanelController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kBackgroundColor,
        child: SlidingUpPanel(
          controller: panelController,
          backdropEnabled: true,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(34),
          ),
          color: kCardPopupBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: kShadowColor,
              offset: Offset(0, -12),
              blurRadius: 32,
            )
          ],
          minHeight: 0,
          maxHeight: MediaQuery.of(context).size.height * 0.95,
          panel: CourseSectionsScreen(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.bottomRight,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration:
                            BoxDecoration(gradient: widget.course.background),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Hero(
                                        tag: widget.course.logo,
                                        child: Image.asset(
                                            'asset/logos/${widget.course.logo}'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Hero(
                                              tag: widget.course.courseSubtitle,
                                              child: Text(
                                                widget.course.courseSubtitle,
                                                style:
                                                    kSecondaryCalloutLabelStyle
                                                        .copyWith(
                                                            color:
                                                                Colors.white70),
                                              ),
                                            ),
                                            Hero(
                                              tag: widget.course.courseTitle,
                                              child: Text(
                                                widget.course.courseTitle,
                                                style:
                                                    kLargeTitleStyle.copyWith(
                                                        color: Colors.white),
                                              ),
                                            )
                                          ]),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: 36,
                                        height: 36,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: kPrimaryLabelColor
                                              .withOpacity(0.8),
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 28,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 28),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 12.5,
                          bottom: 13.5,
                          left: 20.5,
                          right: 14.5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: kShadowColor,
                              blurRadius: 16,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        width: 60,
                        height: 60,
                        child: Image.asset('asset/icons/icon-play.png'),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 12,
                    left: 28,
                    right: 28,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Container(
                                child: CircleAvatar(
                                  child: Icon(
                                    Platform.isAndroid
                                        ? Icons.people
                                        : CupertinoIcons.group_solid,
                                    color: Colors.white,
                                  ),
                                  radius: 21,
                                  backgroundColor: kCourseElementIconColor,
                                ),
                                decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  borderRadius: BorderRadius.circular(29),
                                ),
                              ),
                            ),
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                              gradient: widget.course.background,
                              borderRadius: BorderRadius.circular(29),
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "28.7k",
                                style: kTitle1Style,
                              ),
                              Text(
                                "Students",
                                style: kSearchPlaceholderStyle,
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Container(
                                child: CircleAvatar(
                                  child: Icon(
                                    Platform.isAndroid
                                        ? Icons.format_quote
                                        : CupertinoIcons.news_solid,
                                    color: Colors.white,
                                  ),
                                  radius: 21,
                                  backgroundColor: kCourseElementIconColor,
                                ),
                                decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  borderRadius: BorderRadius.circular(29),
                                ),
                              ),
                            ),
                            height: 58,
                            width: 58,
                            decoration: BoxDecoration(
                              gradient: widget.course.background,
                              borderRadius: BorderRadius.circular(29),
                            ),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "12.4k",
                                style: kTitle1Style,
                              ),
                              Text(
                                "Comments",
                                style: kSearchPlaceholderStyle,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      indicators(),
                      GestureDetector(
                        onTap: () {
                          panelController.open();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: kShadowColor,
                            boxShadow: [
                              BoxShadow(
                                color: kShadowColor,
                                offset: Offset(0, 12),
                                blurRadius: 16,
                              )
                            ],
                            borderRadius: BorderRadius.circular(14),
                          ),
                          width: 80,
                          height: 40,
                          child: Text(
                            "View all",
                            style: kSearchTextStyle,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Computer Science and Engineering is an academic program at many universities which comprises scientific and engineering aspects of computing. CSE is also a term often used in Europe to translate the name of engineering informatics academic programs",
                        style: kBodyLabelStyle,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        "About this course",
                        style: kTitle1Style,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        "The Computer Science and Engineering major thus requires a total of 60 pure CSE course credits and a four-credit senior internship/project. The approved UGC curriculum stipulates a total of 136 credits for the Bachelor of Science degree. A student doing a CSE major is free to use the remaining 72 credits to fulfill the University’s general education and other requirements such as complete voluntary minors. As is customary in liberal arts education, a student needs about half of the total credits to complete the major requirements.",
                      ),
                      SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
