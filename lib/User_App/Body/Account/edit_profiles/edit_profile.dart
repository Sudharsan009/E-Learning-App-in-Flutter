import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_route_animator/page_route_animator.dart';

class EditProfile extends StatefulWidget {
  final User user;
  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _dateinput = TextEditingController();
  File? profilePicture;
  String? profilePictureUrl;
  bool _isUploading = false;

  void initState() {
    _dateinput.text = '';
    super.initState();
    saveUserData();
  }

  Future<void> _pickProfilePicture() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowCompression: true,
    );
    setState(() {
      profilePicture = result?.files.single.path != null
          ? File(result!.files.single.path!)
          : null;
    });
  }

  void saveUserData() async {
    if (mounted) {
      try {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('user')
            .doc(widget.user.uid)
            .get();
        setState(() {
          _username.text = userData['username'] ?? '';
          _bio.text = userData['bio'] ?? '';
          _mobile.text = userData['mobile'] ?? '';
          _dateinput.text = userData['dob'] ?? '';
          profilePictureUrl = userData['profilePictureUrl'] ?? '';
        });
      } catch (e) {
        print('Error in saveUserData: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25))),
          backgroundColor: Colors.purple,
          title: Text(
            "Edit Profile",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Container(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 50.0,
                          backgroundImage: profilePicture != null
                              ? FileImage(
                                  profilePicture!) // Use FileImage for local files
                              : widget.user.photoURL != null
                                  ? NetworkImage(widget.user.photoURL!)
                                  : AssetImage('assets/Icons/user_1.png')
                                      as ImageProvider<Object>,
                        ),
                        Positioned(
                          right: 3,
                          bottom: 20,
                          child: InkWell(
                            onTap: () {
                              _pickProfilePicture();
                            },
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _username,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        labelText: 'UserName',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIconColor: Colors.purple,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: _bio,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_pin_outlined),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        labelText: 'Bio',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIconColor: Colors.purple,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      maxLength: 10,
                      style: TextStyle(color: Colors.white),
                      controller: _mobile,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.call),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        labelText: 'Mobile No',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIconColor: Colors.purple,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        controller: _dateinput,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            prefixIcon: Icon(Icons.calendar_month),
                            prefixIconColor: Colors.purple,
                            labelText: "Enter DOB",
                            labelStyle: TextStyle(color: Colors.white)),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2025));
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                            setState(() {
                              _dateinput.text = formattedDate;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple),
                        ),
                        onPressed: _isUploading
                            ? null
                            : () async {
                                if (await checkInternetConnection()) {
                                  updateProfile();
                                } else {
                                  showNoInternetDialog(context);
                                }
                              },
                        child: _isUploading
                            ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : Text(
                                'Save Change',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateProfile() async {
    try {
      String? profilePictureUrl;
      if (profilePicture != null) {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('profilepic')
            .child(widget.user.uid);

        setState(() {
          _isUploading = true;
        });

        UploadTask uploadTask = storageReference.putFile(profilePicture!);
        await uploadTask.whenComplete(() async {
          String imageUrl = await storageReference.getDownloadURL();
          profilePictureUrl = imageUrl;
        });
      }
      await widget.user.updatePhotoURL(profilePictureUrl);
      await widget.user.updateDisplayName(_username.text);

      await FirebaseFirestore.instance
          .collection('user')
          .doc(widget.user.uid)
          .set({
        'username': _username.text,
        'bio': _bio.text,
        'mobile': _mobile.text,
        'dob': _dateinput.text,
        'profilePictureUrl': profilePictureUrl
      }, SetOptions(merge: true));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Profile updated successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pop();

      saveUserData();

      setState(() {
        _isUploading = false;
      });
    } catch (e) {
      setState(() {
        _isUploading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Profile not updated'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
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

  @override
  void dispose() {
    _username.dispose();
    _bio.dispose();
    _mobile.dispose();
    _dateinput.dispose();
    super.dispose();
  }
}
