import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_route_animator/page_route_animator.dart';
import 'user_login.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  bool _passwordvisible = false;

  bool isStrongPassword(String password) {
    if (password.length < 8) {
      return false;
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }
    return true;
  }

  bool isValidGmail(String email) {
    return RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$').hasMatch(email);
  }

  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  Future<void> signin(BuildContext context) async {
    try {
      String password = _passwordcontroller.text;

      if (!isStrongPassword(password)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Password must be at least 8 characters long'
                  ' contain at least one uppercase letter'
                  'one lowercase letter,one digit '
                  ' one special character.'),
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
        return;
      }
      String email = _emailcontroller.text;

      if (!isValidGmail(email)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Please enter a valid Gmail address.'),
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
        return;
      }

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailcontroller.text, password: _passwordcontroller.text);
      Navigator.pushReplacement(
        context,
        PageRouteAnimator(
          child: Login(),
          routeAnimation: RouteAnimation.rightToLeft,
          duration: Duration(milliseconds: 200),
          reverseDuration: Duration(milliseconds: 200),
        ),
      );
    } catch (e) {
      if (e is FirebaseAuthException && e.code == "email-already-in-use") {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Already Registered'),
              content: Text('The provided email address is already in use.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Ok'),
                ),
              ],
            );
          },
        );
      } else {
        print("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 250,
                    width: 300,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/Images/man-working (1).png'))),
                  ),
                  Text(
                    'SignIn Now',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    "Please fill the details for create a new account",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.white),
                        prefixIconColor: Colors.purple),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordcontroller,
                    obscureText: !_passwordvisible,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordvisible = !_passwordvisible;
                            });
                          },
                          icon: Icon(
                            _passwordvisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.purple,
                          )),
                      prefixIconColor: Colors.purple,
                      suffixIconColor: Colors.purple,
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      labelStyle: TextStyle(color: Colors.white),
                      labelText: 'Password',
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 40,
                    width: MediaQuery.sizeOf(context).width,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.purple),
                          animationDuration: Duration(milliseconds: 200)),
                      onPressed: () {
                        signin(context);
                      },
                      child: Text(
                        'SignUp',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
