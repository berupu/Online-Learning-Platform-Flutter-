import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/screens/course_screen.dart';
import '../../model/course.dart';
import '../cards/explore_course_card.dart';

class ExploreCourseList extends StatefulWidget {
  @override
  State<ExploreCourseList> createState() => _ExploreCourseListState();
}

class _ExploreCourseListState extends State<ExploreCourseList> {
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
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: exploreCourses.length,
        itemBuilder: (context, index) {
          number = index;
          return ExploreCourseCard(course: exploreCourses[index]);
        },
      ),
    );
  }
}
