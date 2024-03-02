import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_route_animator/page_route_animator.dart';
import '../video_page/video_page_ja.dart';

class Java extends StatefulWidget {
  const Java({super.key});

  @override
  State<Java> createState() => _JavaState();
}

class _JavaState extends State<Java> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.purple,
          title: Text(
            'Details',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: 250,
                        width: 500,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/Images/java.jpg')),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Java Full Stack Develpment',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'About Course',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        " A full-stack developer works on both the client-side and server-side programming. Their skill levels are such that they can shift from one language to another or from one technology to another without difficulty.",
                        style: TextStyle(color: Colors.white),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 20,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Java Full Stack')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      List<DocumentSnapshot> document = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: document.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data =
                              document[index].data() as Map<String, dynamic>;
                          String? videoname = data['video name'];
                          String? download_url = data['download_url'];
                          return ListTile(
                            title: Text(
                              videoname ?? 'No Name',
                              style: TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              if (download_url != null) {
                                Navigator.push(
                                  context,
                                  PageRouteAnimator(
                                    child: videopageja(videourl: download_url),
                                    routeAnimation: RouteAnimation.rightToLeft,
                                    duration: Duration(milliseconds: 200),
                                    reverseDuration:
                                        Duration(milliseconds: 200),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text("Video URL is null")),
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
