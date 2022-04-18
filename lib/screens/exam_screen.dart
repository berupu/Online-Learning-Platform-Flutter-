import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/constants.dart';

class ExamScreen extends StatefulWidget {
  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  var examName = "Loading..";
  var examDate = "Loading..";
  var question = "Loading..";
  var submissionLink = "Loading..";

  @override
  void initState() {
    super.initState();
    getQuestion();
  }

  void getQuestion() {
    _storage.ref("exam_questions/question.png").getDownloadURL().then((url) {
      _firestore.collection("exams").doc("questionPattern").update({
        'question': url,
      }).then((value) {
        _firestore
            .collection("exams")
            .doc("questionPattern")
            .get()
            .then((snapshot) {
          setState(() {
            examName = snapshot.data()!["examName"];
            examDate = snapshot.data()!["examDate"];
            question = snapshot.data()!["question"];
            submissionLink = snapshot.data()!["submissionLink"];
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Container(
          color: kBackgroundColor,
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Text("Exam Name: ${examName}", style: kCalloutLabelStyle),
                SizedBox(height: 5),
                Text("Exam Date: ${examDate}", style: kCalloutLabelStyle),
                SizedBox(height: 10),
                Divider(height: 50, thickness: 2),
                Text("Question", style: kCalloutLabelStyle),
                SizedBox(height: 10),
                Image.network(question),
                SizedBox(height: 20),
                Divider(height: 50, thickness: 2),
                Text(
                    "Please upload a PDF format of your answer below this link...",
                    style: kCalloutLabelStyle),
                TextField(
                  controller: TextEditingController(text: "${submissionLink}"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
