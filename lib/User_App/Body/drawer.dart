import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_project/User_App/Body/course_page.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'bookmark.dart';
import '../Signin/user_login.dart';
import 'Account/edit_profiles/edit_profile.dart';

class drawerbar extends StatefulWidget {
  final User user;
  const drawerbar({super.key, required this.user});

  @override
  State<drawerbar> createState() => _drawerbarState();
}

class _drawerbarState extends State<drawerbar> {
  File? _profilePicture;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25))),
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              radius: 50.0,
              backgroundImage: _profilePicture != null
                  ? FileImage(_profilePicture!)
                  : widget.user.photoURL != null
                      ? NetworkImage(widget.user.photoURL!)
                      : AssetImage(
                          'assets/Icons/user_1.png',
                        ) as ImageProvider<Object>,
            ),
            accountName: Text(
              "${widget.user.displayName ?? ''}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              '${widget.user.email}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(color: Colors.purple),
            otherAccountsPictures: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteAnimator(
                        child: EditProfile(
                          user: widget.user,
                        ),
                        routeAnimation: RouteAnimation.rightToLeft,
                        duration: Duration(milliseconds: 200),
                        reverseDuration: Duration(milliseconds: 200),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                  )),
            ],
          ),
          ListTile(
            onTap: () {
              Navigator.pushReplacement(
                context,
                PageRouteAnimator(
                  child: course(user: widget.user),
                  routeAnimation: RouteAnimation.rightToLeft,
                  duration: Duration(milliseconds: 200),
                  reverseDuration: Duration(milliseconds: 200),
                ),
              );
            },
            title: Text(
              "Home",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.home_filled,
              color: Colors.purple,
            ),
          ),
          Divider(
            color: Colors.grey,
            indent: 15,
            endIndent: 15,
            height: 0,
            thickness: 1,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                context,
                PageRouteAnimator(
                  child: bookmarked(),
                  routeAnimation: RouteAnimation.rightToLeft,
                  duration: Duration(milliseconds: 200),
                  reverseDuration: Duration(milliseconds: 200),
                ),
              );
            },
            title: Text(
              "Bookmark",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.bookmark_border,
              color: Colors.purple,
            ),
          ),
          Divider(
            color: Colors.grey,
            indent: 15,
            endIndent: 15,
            height: 0,
            thickness: 1,
          ),
          Divider(
            color: Colors.grey,
            indent: 15,
            endIndent: 15,
            height: 0,
            thickness: 1,
          ),
          ListTile(
            onTap: () async {
              if (await checkInternetConnection()) {
                _showConfirmDialog(context);
              } else {
                showNoInternetDialog(context);
              }
            },
            title: Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.purple,
            ),
          ),
          Divider(
            color: Colors.grey,
            indent: 15,
            endIndent: 15,
            height: 0,
            thickness: 1,
          ),
        ],
      ),
    );
  }
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

void _showConfirmDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();

              Navigator.popUntil(
                context,
                (route) => route.isFirst,
              );

              Navigator.pushReplacement(
                context,
                PageRouteAnimator(
                  child: Login(),
                  routeAnimation: RouteAnimation.rightToLeft,
                  duration: Duration(milliseconds: 200),
                  reverseDuration: Duration(milliseconds: 200),
                ),
              );
            },
            child: const Text('Yes'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No'),
          ),
        ],
      );
    },
  );
}
