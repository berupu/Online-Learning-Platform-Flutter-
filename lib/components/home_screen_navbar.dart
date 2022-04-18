import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/components/searchfield_widget.dart';
import 'package:flutter_first/components/sidebar_button.dart';
import 'package:flutter_first/constants.dart';
import 'package:flutter_first/screens/profile_screen.dart';

class HomeScreenNavBar extends StatelessWidget {
  HomeScreenNavBar({required this.triggerAnimation});

  final Function triggerAnimation;

  final photoURL = FirebaseAuth.instance.currentUser?.photoURL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Row(
        children: [
          SideBarButton(
            triggerAnimation: triggerAnimation,
          ),
          SearchFieldWidget(),
          Icon(
            Icons.notifications,
            color: kPrimaryLabelColor,
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: CircleAvatar(
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
          )
        ],
      ),
    );
  }
}
