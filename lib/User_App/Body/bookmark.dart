import 'package:flutter/material.dart';
import 'package:page_route_animator/page_route_animator.dart';

class Bookmarks {
  final String title;
  final Widget page;

  Bookmarks({required this.title, required this.page});
}

class bookmarked extends StatelessWidget {
  static List<Bookmarks> bookmarkedCourse = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          title: Text(
            'Bookmarks',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView.builder(
          itemCount: bookmarkedCourse.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: ListTile(
                title: Container(
                  padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
                  height: 40,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Text(
                    bookmarked.bookmarkedCourse[index].title,
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteAnimator(
                      child: bookmarked.bookmarkedCourse[index].page,
                      routeAnimation: RouteAnimation.rightToLeft,
                      duration: Duration(milliseconds: 200),
                      reverseDuration: Duration(milliseconds: 200),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
