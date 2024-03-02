import 'package:chewie/chewie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../Flutter/about_flutter.dart';
import 'Notes.dart';
import 'resource.dart';

class videopageja extends StatefulWidget {
  final String videourl;
  videopageja({super.key, required this.videourl});

  @override
  State<videopageja> createState() => _videopagejaState();
}

class _videopagejaState extends State<videopageja> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;

  bool _isinitialised = false;
  late String _share = "";

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
    return 'https://firebasestorage.googleapis.com/v0/b/newproject-9ec3c.appspot.com/o/lecture%2F1000017103.mp4?alt=media&token=dccdbdd4-7aa3-4f90-8810-8c78f0210cfe';
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: SafeArea(
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
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
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
                                Share.share(_share);
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
