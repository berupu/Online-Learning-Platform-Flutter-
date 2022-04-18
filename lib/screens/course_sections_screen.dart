import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/components/cards/explore_course_card.dart';
import 'package:flutter_first/components/lists/explore_course_list.dart';
import 'package:flutter_first/model/course.dart';

import '../components/lists/course_sections_list.dart';
import '../constants.dart';

class CourseSectionsScreen extends StatefulWidget {
  const CourseSectionsScreen({Key? key}) : super(key: key);

  @override
  State<CourseSectionsScreen> createState() => _CourseSectionsScreenState();
}

class _CourseSectionsScreenState extends State<CourseSectionsScreen> {
  List<Course> exploreCourses = [];
  final _firestore = FirebaseFirestore.instance;

  var number = 0;

  @override
  void initState() {
    super.initState();
    grabCourses();
  }

  void grabCourses() {
    //Get the courses from firestore.
    _firestore.collection("courses").get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          exploreCourses.add(Course(
              courseTitle: doc["courseTitle"],
              courseSubtitle: doc["courseSubtitle"],
              logo: doc["logo"],
              background: LinearGradient(colors: [
                Color(int.parse(doc["colors"][0])),
                Color(int.parse(doc["colors"][1])),
              ])));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(34),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: kCardPopupBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(34),
                bottomLeft: Radius.circular(34),
              ),
              boxShadow: [
                BoxShadow(
                  color: kShadowColor,
                  offset: Offset(0, 12),
                  blurRadius: 32,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Course Sections",
                  style: kTitle2Style,
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.black,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 151,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: exploreCourses.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ExploreCourseCard(course: exploreCourses[index]),
                    SizedBox(height: 32),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
