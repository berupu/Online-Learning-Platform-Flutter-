import 'package:flutter/material.dart';

class Course {
  Course({
    required this.courseTitle,
    required this.courseSubtitle,
    required this.background,
    required this.logo,
  });

  String courseTitle;
  String courseSubtitle;
  LinearGradient background;
  String logo;
}

// Recent Courses
var recentCourses = [
  Course(
    courseTitle: "Programming Language I",
    courseSubtitle: "CSE 110",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF00AEFF),
        Color(0xFF0076FF),
      ],
    ),
    logo: 'brac.png',
  ),
  Course(
    courseTitle: "Programming Language II",
    courseSubtitle: "CSE 111",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFD504F),
        Color(0xFFFF8181),
      ],
    ),
    logo: 'brac.png',
  ),
  Course(
    courseTitle: "Algorithm",
    courseSubtitle: "CSE 220",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF00E1EE),
        Color(0xFF001392),
      ],
    ),
    logo: 'brac.png',
  ),
  Course(
    courseTitle: "Artifical Intelligence",
    courseSubtitle: "CSE 422",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF4E62CC),
        Color(0xFF202A78),
      ],
    ),
    logo: 'brac.png',
  ),
  Course(
    courseTitle: "VLSI Design",
    courseSubtitle: "CSE 461",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFA7D75),
        Color(0xFFC23D61),
      ],
    ),
    logo: 'brac.png',
  ),
];

// Explore Courses
var exploreCourses = [
  Course(
    courseTitle: "Discrete Mathematics",
    courseSubtitle: "CSE 230",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF5BCEA6),
        Color(0xFF1997AB),
      ],
    ),
    logo: 'brac.png',
  ),
  Course(
    courseTitle: "Mobile Application Deve",
    courseSubtitle: "CSE 489",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFA931E5),
        Color(0xFF4B02FE),
      ],
    ),
    logo: 'brac.png',
  ),
];

// Continue Watching Courses
var continueWatchingCourses = [
  Course(
    courseTitle: "Artifical Intelligence",
    courseSubtitle: "CSE 422",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF4E62CC),
        Color(0xFF202A78),
      ],
    ),
    logo: 'brac.png',
  ),
  Course(
    courseTitle: "VLSI Design",
    courseSubtitle: "CSE 461",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFA7D75),
        Color(0xFFC23D61),
      ],
    ),
    logo: 'brac.png',
  ),
  Course(
    courseTitle: "Compiler Design",
    courseSubtitle: "CSE 420",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFF6B94),
        Color(0xFF6B2E98),
      ],
    ),
    logo: 'brac.png',
  ),
  Course(
    courseTitle: "Mobile Application",
    courseSubtitle: "CSE 489",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFDEC8FA),
        Color(0xFF4A1B6D),
      ],
    ),
    logo: 'brac.png',
  ),
];

// Course Sections
var courseSections = [
  Course(
    courseTitle: "Software Engineering",
    courseSubtitle: "CSE 470",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF00AEFF),
        Color(0xFF0076FF),
      ],
    ),
    logo: 'brac.png',
  ),
  Course(
    courseTitle: "System Analysis and Design",
    courseSubtitle: "CSE 471",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFE477AE),
        Color(0xFFC54284),
      ],
    ),
    logo: 'brac.png',
  ),
  Course(
    courseTitle: "Microprocessor",
    courseSubtitle: "CSE 341",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFEA7E58),
        Color(0xFFCE4E27),
      ],
    ),
    logo: 'brac.png',
  ),
  Course(
    courseTitle: "Computer Interface",
    courseSubtitle: "CSE 360",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF72CFD4),
        Color(0xFF42A0C2),
      ],
    ),
    logo: 'brac.png',
  ),
  Course(
    courseTitle: "Computer Networks",
    courseSubtitle: "CSE 421",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFF2E56),
        Color(0xFFCB012B),
      ],
    ),
    logo: 'brac.png',
  ),
];

// Completed Courses
var completedCourses = [
  Course(
    courseTitle: "Compiler Design",
    courseSubtitle: "CSE 420",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFF6B94),
        Color(0xFF6B2E98),
      ],
    ),
    logo: 'brac.png',
  ),
  Course(
    courseTitle: "Data Communication",
    courseSubtitle: "CSE 320",
    background: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFDEC8FA),
        Color(0xFF4A1B6D),
      ],
    ),
    logo: 'brac.png',
  ),
];
