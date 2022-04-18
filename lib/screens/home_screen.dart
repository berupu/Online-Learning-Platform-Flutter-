import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/screens/course_screen.dart';
import 'package:flutter_first/screens/course_sections_screen.dart';
import 'package:flutter_first/screens/sidebar_screen.dart';
import '../components/home_screen_navbar.dart';
import '../components/lists/explore_course_list.dart';
import '../components/lists/recent_course_list.dart';
import '../constants.dart';
import 'continue_watching_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late Animation<Offset> sidebarAnimation;
  late Animation<double> fadeAnimation;
  late AnimationController sidebarAnimationController;

  var sidebarHidden = true;

  @override
  void initState() {
    super.initState();
    sidebarAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    sidebarAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: sidebarAnimationController,
        curve: Curves.easeInOut,
      ),
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: sidebarAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    sidebarAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kBackgroundColor,
        child: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(right: 20, left: 20, bottom: 100),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      HomeScreenNavBar(
                        triggerAnimation: () {
                          setState(() {
                            sidebarHidden = !sidebarHidden;
                          });
                          sidebarAnimationController.forward();
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Recents",
                            style: kLargeTitleStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RecentCourseList(),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 25,
                          bottom: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Explore",
                                  style: kTitle1Style,
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CourseSectionsScreen()));
                                  },
                                  child: Text(
                                    "See all",
                                    style: kSearchPlaceholderStyle,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ExploreCourseList(),
                    ],
                  ),
                ),
              ),
            ),
            ContinueWatchingScreen(),
            IgnorePointer(
              //ignore taps
              ignoring: sidebarHidden,
              child: Stack(
                children: [
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: GestureDetector(
                      child: Container(
                        color: Color.fromRGBO(32, 38, 41, 0.4),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                      ),
                      onTap: () {
                        setState(() {
                          sidebarHidden = !sidebarHidden;
                        });
                        sidebarAnimationController.reverse();
                      },
                    ),
                  ),
                  SlideTransition(
                    position: sidebarAnimation,
                    child: SafeArea(
                      child: SidebarScreen(),
                      bottom: false,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
