import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/buttons.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static final String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  var password;
  var emailAddress;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  emailAddress = value;
                  //Do something with the user input.
                },
                decoration: kInputDecorationStyle,
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kInputDecorationStyle.copyWith(
                    hintText: 'Enter your Password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              Button(
                  text: 'Log in',
                  color: Colors.lightBlueAccent,
                  route: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final user = await _auth
                          .signInWithEmailAndPassword(
                              email: emailAddress, password: password)
                          .catchError((err) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Unable to Log in"),
                                content: Text(err.message),
                                actions: [
                                  TextButton(
                                    child: Text("Try again"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                        setState(() {
                          showSpinner = false;
                        });
                      });
                      if (user != null) {
                        Navigator.pushNamed(context, ChatScreen.id);
                        setState(() {
                          showSpinner = false;
                        });
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

//            TextField(
//               style: TextStyle(color: Colors.black),
//               onChanged: (value) {
//                 //Do something with the user input.
//                 String displayName = value;
//                 _auth.currentUser?.updateDisplayName(displayName);
//               },
//               decoration:
//                   kInputDecorationStyle.copyWith(hintText: 'Create a Username'),
//             ),
//             SizedBox(
//               height: 24.0,
//             ),
