import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/screens/login_screen.dart';

import '../components/sidebar_row.dart';
import '../constants.dart';
import '../model/sidebar.dart';

class SidebarScreen extends StatefulWidget {
  @override
  State<SidebarScreen> createState() => _SidebarScreenState();
}

class _SidebarScreenState extends State<SidebarScreen> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  var photoURL = FirebaseAuth.instance.currentUser?.photoURL;

  var name = "Loding...";
  var bio = "Loding...";

  @override
  void initState() {
    super.initState();
    loadUserData();
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kSidebarBackgroundColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(34.0),
        ),
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.85,
      padding: EdgeInsets.symmetric(
        vertical: 35,
        horizontal: 20,
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0xFFE7EEFB),
                  child: (photoURL != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            photoURL!,
                            width: 36,
                            height: 36,
                          ))
                      : Icon(Icons.person),
                  radius: 18,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: kHeadlineLabelStyle,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      bio,
                      style: kSearchPlaceholderStyle,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            SidebarRow(
              item: sidebarItem[0],
            ),
            SizedBox(
              height: 32,
            ),
            SidebarRow(
              item: sidebarItem[1],
            ),
            SizedBox(
              height: 32,
            ),
            SidebarRow(
              item: sidebarItem[2],
            ),
            SizedBox(
              height: 32,
            ),
            SidebarRow(
              item: sidebarItem[3],
            ),
            SizedBox(
              height: 32,
            ),
            Spacer(),
            Row(
              children: [
                Image.asset(
                  'asset/icons/icon-logout.png',
                  width: 17,
                ),
                SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    "Log out",
                    style: kSecondaryCalloutLabelStyle,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
