import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/User_App/Body/drawer.dart';
import 'package:page_route_animator/page_route_animator.dart';
import '../Courses/Flutter/Flutter.dart';
import '../Courses/Java/Java.dart';
import '../Courses/MERN/Mern.dart';
import '../Courses/Python/Python.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:new_project/User_App/Body/bookmark.dart';

class course extends StatefulWidget {
  final User user;
  const course({Key? key, required this.user}) : super(key: key);

  @override
  State<course> createState() => _courseState();
}

class _courseState extends State<course> {
  bool constraint = false;
  bool isBookmark = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: drawerbar(
          user: widget.user,
        ),
        extendBody: true,
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          title: Text(
            "Welcome! ${widget.user.displayName ?? ''}",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          leading: Builder(builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                    color: Colors.purple.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                child: IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: widget.user.photoURL != null
                        ? NetworkImage(widget.user.photoURL!)
                        : AssetImage('assets/Icons/user_1.png')
                            as ImageProvider<Object>,
                  ),
                  color: Colors.white,
                ),
              ),
            );
          }),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                      onNavigateToCoursePage: navigateToCoursePage),
                );
              },
            )
          ],
          backgroundColor: Colors.purple,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return buildCourseCard(index);
              },
            );
          },
        ),
      ),
    );
  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  void showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('No Internet Connection'),
          content: Text('Please turn on your internet connection.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            )
          ],
        );
      },
    );
  }

  Widget buildCourseCard(int index) {
    List<String> titles = [
      'Flutter App Development',
      'MERN Full Stack Development',
      'Java Full Stack Development',
      'Python Full Stack Development',
    ];

    List<String> images = [
      'assets/Images/Flutter.png',
      'assets/Images/mern.jpg',
      'assets/Images/java.jpg',
      'assets/Images/python.jpg',
    ];

    bool isCourseBookmarked = bookmarked.bookmarkedCourse
        .any((bookmark) => bookmark.title == titles[index]);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => navigateToCoursePage(getCoursePage(index)),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(images[index]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    titles[index],
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      if (await checkInternetConnection()) {
                        setState(() {
                          if (isCourseBookmarked) {
                            bookmarked.bookmarkedCourse.removeWhere(
                                (bookmark) => bookmark.title == titles[index]);
                          } else {
                            bookmarked.bookmarkedCourse.add(Bookmarks(
                              title: titles[index],
                              page: getCoursePage(index),
                            ));
                          }
                        });
                      } else {
                        showNoInternetDialog(context);
                      }
                    },
                    icon: Icon(
                      isCourseBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_border,
                      color: isCourseBookmarked ? Colors.purple : null,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getCoursePage(int index) {
    switch (index) {
      case 0:
        return Flutter();
      case 1:
        return MERN();
      case 2:
        return Java();
      case 3:
        return Python();
      default:
        return Flutter();
    }
  }

  void navigateToCoursePage(Widget coursePage) {
    Navigator.push(
      context,
      PageRouteAnimator(
        child: coursePage,
        routeAnimation: RouteAnimation.rightToLeft,
        duration: Duration(milliseconds: 200),
        reverseDuration: Duration(milliseconds: 200),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final void Function(Widget) onNavigateToCoursePage;
  CustomSearchDelegate({required this.onNavigateToCoursePage});

  List<String> SearchItems = [
    "Flutter App Development",
    "Java Full Stack",
    "Mern Full Stack",
    "Python Full Stack"
  ];
  Widget getCoursePageByTitle(String title) {
    switch (title) {
      case "Flutter App Development":
        return Flutter();
      case "Java Full Stack":
        return Java();
      case "Mern Full Stack":
        return MERN();
      case "Python Full Stack":
        return Python();
      default:
        return Flutter();
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchquery = [];
    for (var development in SearchItems) {
      if (development.toLowerCase().contains(query.toLowerCase())) {
        matchquery.add(development);
      }
    }
    return ListView.builder(
      itemCount: matchquery.length,
      itemBuilder: (context, index) {
        var result = matchquery[index];
        return ListTile(
          title: Text(result),
          onTap: () => onNavigateToCoursePage(getCoursePageByTitle(result)),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchquery = [];
    for (var development in SearchItems) {
      if (development.toLowerCase().contains(query.toLowerCase())) {
        matchquery.add(development);
      }
    }
    return ListView.builder(
      itemCount: matchquery.length,
      itemBuilder: (context, index) {
        var result = matchquery[index];
        return ListTile(
          title: Text(result),
          onTap: () {
            onNavigateToCoursePage(getCoursePageByTitle(result));
          },
        );
      },
    );
  }
}
