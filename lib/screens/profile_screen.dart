import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/components/certificate_viewer.dart';
import 'package:flutter_first/components/lists/completed_course-list.dart';
import 'package:flutter_first/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var badges = [];

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _storage = FirebaseStorage.instance;

  var name = "Loding...";
  var bio = "Loding...";
  var photoURL = FirebaseAuth.instance.currentUser?.photoURL;

  @override
  void initState() {
    super.initState();
    //_auth.currentUser.reload();
    loadUserData();
    loadBadges();
  }

  Future getImage() async {
    //Pick Image from Gallay ...For iOS simulator change info.plist
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File _image = File(pickedFile.path);

      //Upload file to firebase
      _storage
          .ref("profile_images/${_auth.currentUser?.uid}.jpg")
          .putFile(_image)
          .then((snapshot) {
        snapshot.ref.getDownloadURL().then((url) {
          _firestore
              .collection("users")
              .doc(_auth.currentUser?.uid)
              .update({'profilePic': url}).then((snapshot) {
            _auth.currentUser?.updateProfile(photoURL: url);
          });
        });
      });
    } else {
      print("A file was not selected");
    }
  }

  void loadUserData() {
    //Firebase Read data for firestore.
    _firestore
        .collection("users")
        .doc(_auth.currentUser?.uid)
        .get()
        .then((snapshot) {
      setState(() {
        name = snapshot.data()!["name"];
        bio = snapshot.data()!["bio"];
      });
    });
  }

  void updateUserData() {
    //Update existing firestore value.

    _firestore.collection("users").doc(_auth.currentUser?.uid).update({
      'name': name,
      'bio': bio,
    }).then((value) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Success"),
              content: Text("The profile data has been updated"),
              actions: [
                RawMaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"))
              ],
            );
          });
    }).catchError((err) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Uh-Oh!"),
              content: Text("${err}"),
              actions: [
                RawMaterialButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Try Again!"))
              ],
            );
          });
    });
  }

  void loadBadges() {
    _firestore
        .collection("users")
        .doc(_auth.currentUser?.uid)
        .get()
        .then((snapshot) {
      for (var badge in snapshot.data()!["badges"]) {
        //Get Firebase file storage URL.
        _storage.ref("badges/$badge").getDownloadURL().then((url) {
          setState(() {
            badges.add(url);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: kCardPopupBackgroundColor,
                borderRadius: BorderRadius.only(
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
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 24,
                        bottom: 32,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          RawMaterialButton(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            constraints: BoxConstraints(
                              minWidth: 40,
                              maxWidth: 40,
                              maxHeight: 24,
                            ),
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    color: kSecondaryLabelColor,
                                  )
                                ]),
                          ),
                          Text(
                            "Profile",
                            style: kCalloutLabelStyle,
                          ),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Update Your Profile"),
                                      content: Column(children: [
                                        TextField(
                                          onChanged: (newValue) {
                                            setState(() {
                                              name = newValue;
                                            });
                                          },
                                          controller: TextEditingController(
                                              text: name), //placeholder
                                        ),
                                        TextField(
                                          onChanged: (newValue) {
                                            setState(() {
                                              bio = newValue;
                                            });
                                          },
                                          controller: TextEditingController(
                                              text: bio), //placeholder
                                        ),
                                      ]),
                                      actions: [
                                        RawMaterialButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              updateUserData();
                                            },
                                            child: Text("Update"))
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: kShadowColor,
                                    offset: Offset(0, 12),
                                    blurRadius: 32,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Platform.isAndroid
                                    ? Icons.edit
                                    : CupertinoIcons.pencil,
                                color: kSecondaryLabelColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              getImage();
                              //print("Call getImage");
                            },
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(6),
                                child: Container(
                                  padding: EdgeInsets.all(6),
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xFFE7EEFB),
                                    child: (photoURL != null)
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Image.network(photoURL!))
                                        : Icon(Icons.person),
                                    radius: 30,
                                  ),
                                  decoration: BoxDecoration(
                                    color: kBackgroundColor,
                                    borderRadius: BorderRadius.circular(42),
                                  ),
                                ),
                              ),
                              height: 84,
                              width: 84,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    Color(0xFF00AEFF),
                                    Color(0xFF0076FF)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(42),
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${name}", style: kTitle2Style),
                              SizedBox(height: 8),
                              Text(
                                "${bio}",
                                style: kSecondaryCalloutLabelStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 28,
                        bottom: 16,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Certificates",
                                  style: kHeadlineLabelStyle,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      height: 112,
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 28),
                        scrollDirection: Axis.horizontal,
                        itemCount: badges.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 20, right: index != 3 ? 0 : 20),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                color: kShadowColor.withOpacity(0.1),
                                offset: Offset(0, 12),
                                blurRadius: 18,
                              )
                            ]),
                            child: Image.network(
                                '${badges[index]}'), //Dowload Image by URL.
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 32,
                left: 20,
                right: 20,
                bottom: 12,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 12,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Completed Courses",
                        style: kHeadlineLabelStyle,
                      ),
                      Row(
                        children: [
                          Text(
                            "See all",
                            style: kSearchPlaceholderStyle,
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: kSecondaryLabelColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            CompletedCoursesList(),
            SizedBox(
              height: 28,
            )
          ],
        ),
      ),
    );
  }
}
