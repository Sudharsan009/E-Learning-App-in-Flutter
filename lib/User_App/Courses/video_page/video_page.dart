import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../Flutter/about_flutter.dart';
import 'Notes.dart';
import 'resource.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class videopage extends StatefulWidget {
  final String videourl;
  videopage({super.key, required this.videourl});

  @override
  State<videopage> createState() => _videopageState();
}

class _videopageState extends State<videopage> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  bool _isinitialised = false;
  late String _share =
      "https://firebasestorage.googleapis.com/v0/b/newproject-9ec3c.appspot.com/o/lecture%2F1000014424.mp4?alt=media&token=200d4213-54a1-4bca-8324-ef8d31cfed7c";

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
    return 'https://firebasestorage.googleapis.com/v0/b/newproject-9ec3c.appspot.com/o/lecture%2F1000014424.mp4?alt=media&token=200d4213-54a1-4bca-8324-ef8d31cfed7c';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          backgroundColor: Colors.blueGrey[900],
          body: SafeArea(
            child: Column(
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
                      'Flutter App Development',
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
                              builder: (context) => AboutFlutter(),
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
