// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_first/constants.dart';
import 'package:flutter_first/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email;
  late String password;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<void> createNewUserData() async {
    //Firestore create data
    _firestore.collection('users').doc(_auth.currentUser?.uid).set({
      'name': 'User',
      'uid': _auth.currentUser?.uid,
      'bio': 'Student',
      'completed': [],
      'recents': [],
      'badges': [],
      'certificates': [],
      'profilePic': ''
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kSidebarBackgroundColor,
        child: ListView(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Image.asset(
                        'asset/logos/brac.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0, -175, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 7,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 190,
                ),
                Container(
                  transform: Matrix4.translationValues(0, -150, 0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 53),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Log in to",
                          style: kTitle1Style,
                        ),
                        Text(
                          "Start Learning",
                          style: kTitle1Style.apply(color: Color(0xFF584CFF0)),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 130,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      color: kShadowColor,
                                      offset: Offset(0, 12),
                                      blurRadius: 16,
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 5, right: 16, left: 16),
                                      child: TextField(
                                        cursorColor: kPrimaryLabelColor,
                                        decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.email,
                                            color: Color(0xFF5488F1),
                                            size: 20,
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Email Address",
                                          hintStyle: kLoginInputTextStyle,
                                        ),
                                        style: kLoginInputTextStyle.copyWith(
                                          color: Colors.black,
                                        ),
                                        onChanged: (textEntered) {
                                          email = textEntered;
                                        },
                                      ),
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          bottom: 5, right: 16, left: 16),
                                      child: TextField(
                                        cursorColor: kPrimaryLabelColor,
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          icon: Icon(
                                            Icons.lock,
                                            color: Color(0xFF5488F1),
                                            size: 20,
                                          ),
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: kLoginInputTextStyle,
                                        ),
                                        style: kLoginInputTextStyle.copyWith(
                                          color: Colors.black,
                                        ),
                                        onChanged: (textEntered) {
                                          password = textEntered;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () async {
                                try {
                                  //Firebase Signin
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                      fullscreenDialog: false,
                                    ),
                                  );
                                } on FirebaseAuthException catch (err) {
                                  if (err.code == "user-not-found") {
                                    try {
                                      //Firebase CreateAccount
                                      await _auth
                                          .createUserWithEmailAndPassword(
                                              email: email, password: password)
                                          .then(
                                        (user) {
                                          //Firebase send emailVerification
                                          user.user?.sendEmailVerification();
                                          createNewUserData();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen(),
                                              fullscreenDialog: false,
                                            ),
                                          );
                                        },
                                      );
                                    } catch (err) {}
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("error"),
                                            content: Text("error"),
                                            actions: [
                                              RawMaterialButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("Ok!"),
                                              ),
                                            ],
                                          );
                                        });
                                  }
                                }
                              },
                              child: Container(
                                child: Text(
                                  "Login",
                                  style: kCalloutLabelStyle.copyWith(
                                      color: Colors.white),
                                ),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF73A0F4),
                                      Color(0xFF4A47F5),
                                    ],
                                  ),
                                ),
                                height: 47,
                                width: MediaQuery.of(context).size.width * 0.3,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            //firebase ResetPassword email
                            _auth
                                .sendPasswordResetEmail(email: email)
                                .then((value) => {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Email Sent!"),
                                            content: Text(
                                                "The password reset email has been sent!"),
                                            actions: [
                                              RawMaterialButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text("OK!"),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    });
                            ;
                          },
                          child: Container(
                            child: Text(
                              "Forgot Password?",
                              style: kCalloutLabelStyle.copyWith(
                                color: Color(0x721B1E9C),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
