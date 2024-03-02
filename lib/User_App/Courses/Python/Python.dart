import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:page_route_animator/page_route_animator.dart';
import '../video_page/video_page_p.dart';

class Python extends StatefulWidget {
  const Python({super.key});

  @override
  State<Python> createState() => _PythonState();
}

class _PythonState extends State<Python> {
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
                              image: AssetImage("assets/Images/python.jpg")),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Pyrhon Full Stack Develpment',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 27,
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
                        'Full-stack development refers to the design, implementation and testing of both the client, and server sides of a web application. A Python full-stack developer is proficient in handling the front- and back-end of a website or an application.',
                        style: TextStyle(color: Colors.white),
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 20,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Python Full Stack')
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
                                    child: videopagepy(videourl: download_url),
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
