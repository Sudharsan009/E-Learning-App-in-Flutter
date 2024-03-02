import 'package:chewie/chewie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../Python/about_python.dart';
import 'Notes.dart';
import 'resource.dart';

class videopagepy extends StatefulWidget {
  final String videourl;
  videopagepy({super.key, required this.videourl});

  @override
  State<videopagepy> createState() => _videopagepyState();
}

class _videopagepyState extends State<videopagepy> {
  late String _share = '';
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  bool _isinitialised = false;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No Internet Connection'),
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      initializeVideo();
    }
  }

  void initializeVideo() {
    _controller = VideoPlayerController.network(widget.videourl)
      ..initialize().then((_) {
        setState(() {
          _isinitialised = true;
          _chewieController = ChewieController(
            videoPlayerController: _controller,
            autoPlay: true,
            looping: false,
          );
        });
      });

    fetchShareUrl().then((url) {
      setState(() {
        _share = url ?? "";
      });
    });
  }

  Future<String?> fetchShareUrl() async {
    await Future.delayed(Duration(seconds: 1));
    return "https://firebasestorage.googleapis.com/v0/b/newproject-9ec3c.appspot.com/o/lecture%2F1000014434.mp4?alt=media&token=fd304bd1-7196-4104-9d74-e2b199763fb8";
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.blueGrey[900],
            body: Column(
              children: [
                _isinitialised
                    ? Container(
                        height: 240,
                        width: MediaQuery.sizeOf(context).width,
                        child: Chewie(
                          controller: _chewieController,
                        ),
                      )
                    : CircularProgressIndicator(),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Python Full Stack Development',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 80,
                  child: AppBar(
                      iconTheme: IconThemeData(color: Colors.purple),
                      backgroundColor: Colors.purple,
                      bottom: const TabBar(
                          unselectedLabelColor: Colors.white,
                          labelColor: Colors.white,
                          dividerColor: Colors.white,
                          indicatorColor: Colors.white,
                          splashBorderRadius:
                              BorderRadius.all(Radius.circular(15)),
                          labelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          tabs: [
                            Tab(
                              text: 'More',
                            ),
                          ])),
                ),
                Expanded(
                    child: TabBarView(
                  children: [
                    ListView(
                      children: [
                        ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (context) => Aboutpython(),
                            );
                          },
                          leading: Icon(
                            Icons.more_horiz,
                            color: Colors.purple,
                          ),
                          title: Text(
                            'About this Course',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            showModalBottomSheet(
                              useSafeArea: true,
                              context: context,
                              builder: (context) => NoteList(),
                            );
                          },
                          leading: Icon(
                            Icons.sticky_note_2_outlined,
                            color: Colors.purple,
                          ),
                          title: Text(
                            'Notes',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            showModalBottomSheet(
                                useSafeArea: true,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) => Resource());
                          },
                          leading: Icon(
                            Icons.menu_book,
                            color: Colors.purple,
                          ),
                          title: Text(
                            'Resource',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                            onTap: () {
                              if (_share.isNotEmpty) {
                                Share.share(_share);
                              } else {
                                print(
                                    "Error: Share URL is empty or not initialized.");
                              }
                            },
                            leading: Icon(
                              Icons.share_rounded,
                              color: Colors.purple,
                            ),
                            title: Text(
                              'Share this course',
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    )
                  ],
                ))
              ],
            ),
          ),
        ));
  }

  shareButton(String title, Function()? onPressed) {
    return ElevatedButton(onPressed: onPressed, child: Text(title));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
