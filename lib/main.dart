import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'User_App/Signin/user_login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: 'AIzaSyC6AU6Sjp1alSzODmrzPCQDsGwna2xl2mg',
    appId: '1:257891899504:android:ed9432077ceffa3150fcb5',
    messagingSenderId: '257891899504',
    projectId: 'newproject-9ec3c',
    storageBucket: 'newproject-9ec3c.appspot.com',
  ));
  runApp(UserApp());
}

class UserApp extends StatelessWidget {
  const UserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
